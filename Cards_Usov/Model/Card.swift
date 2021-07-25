//
//  Card.swift
//  Card
//
//  Created by Андрей Бородкин on 25.07.2021.
//

import UIKit

// card types
enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
}

// card colours
enum CardColor: CaseIterable {
    case red
    case green
    case black
    case grey
    case brown
    case yellow
    case purple
    case orange
}

// game card
typealias Card = (type: CardType, color: CardColor)
