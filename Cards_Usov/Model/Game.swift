//
//  Game.swift
//  Game
//
//  Created by Андрей Бородкин on 25.07.2021.
//

import Foundation


class Game {
    // pair number of unique cards
    var cardsCount = 0
    // array of generated cards
    var cards = [Card]()
    
    // generation of cards array
    func generateCards() {
        var cards = [Card]()
        for _ in 0...cardsCount {
            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        self.cards = cards
    }
    
    // card equality check
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        if firstCard == secondCard {
            return true
        }
        return false
    }
    
}
