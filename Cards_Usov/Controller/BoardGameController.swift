//
//  BoardGameController.swift
//  BoardGameController
//
//  Created by Андрей Бородкин on 25.07.2021.
//

import UIKit

class BoardGameController: UIViewController {

    
    // number of unique card pairs
    var cardPairsCount = 8
    // Game entity
    lazy var game: Game = getNewGame()
    
    // start/restart game button
    lazy var startButtonView = getStartButtonView()
    
    // game field
    lazy var boardGameView = getBoardGameView()
    
    var cardViews: [UIView] = []
    
    private var flippedCards = [UIView]()
    
    // card sizes
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    // max placement coordinates of the card
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    
    

    
    
    
    override func loadView() {
        super.loadView()
        
        // add button to scene
        view.addSubview(startButtonView)
        // add game field to scene
        view.addSubview(boardGameView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardPairsCount
        game.generateCards()
        return game
    }
    
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
        
        print(cards[0])
        // at this point everything stopped working
        // card are generated but not displayed
    }
    
    private func getStartButtonView() -> UIButton {
        // 1
        // creates button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2
        // change button position
        button.center.x = view.center.x
        
        // access current window
        let window = UIApplication.shared.windows[0]
        // decide on the top margin from window boundary to Safe are
        let topPadding = window.safeAreaInsets.top
        // sets Y coordinate of the button according to the margin
        button.frame.origin.y = topPadding
        
        // 3
        // sets button appearance
        
        // set text
        button.setTitle("Start Game", for: .normal)
        // set text color for standard (not pressed state)
        button.setTitleColor(.black, for: .normal)
        // set text color for pressed state
        button.setTitleColor(.gray, for: .highlighted)
        // set background color
        button.backgroundColor = .systemGray4
        // round corners
        button.layer.cornerRadius = 10
        
        // connect handler to the button
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }

    
    
    private func getBoardGameView() -> UIView {
        // margin from game field to nearest elements
        let margin: CGFloat = 10
        
        let boardView = UIView()
        
        // designate coordinates
        // x
        boardView.frame.origin.x = margin
        // y
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        
        // calculate width
        boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
        // calculate height (taking into account bottom margin)
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        // change game field style
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    // generate an array of cards based on model data
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // storage for card views
        var cardViews = [UIView]()
        // card factory
        let cardViewFactory = CardViewFactory()
        // go through cards array
        for (index, modelCard) in modelData.enumerated() {
            // add first instance of a card
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        // add to all cards flip handler
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { [self] flippedCard in
                // move up card in hierarchy
                flippedCard.superview?.bringSubviewToFront(flippedCard)
                
                // add or delete card
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                // if 2 cards are flipped
                if self.flippedCards.count == 2 {
                    // get cards from model
                    let firstCard = game.cards[self.flippedCards.first!.tag]
                    let secondCard = game.cards[self.flippedCards.first!.tag]
                    
                    // if cards are equal
                    if game.checkCards(firstCard, secondCard) {
                        // first hide them with animation
                        UIView.animate(withDuration: 0.3, animations: {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                            // then remove from hierarchy
                        }, completion: {_ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        })
                        // otherwise
                    } else {
                        // turn card up
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
        }
        return cardViews
    }
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // delete all current cards on field
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        // go through cards
        for card in cardViews {
            // for each card generate random coordinates
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            
            // place a card on game field
            boardGameView.addSubview(card)
        }
    }
    
    
}
