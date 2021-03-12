//
//  UILabelExtension.swift
//  JuiceMaker
//
//  Created by 천수현 on 2021/03/11.
//

import Foundation
import UIKit

class StockLabel: UILabel {
    var fruit: Fruit = FruitType.strawberry
    func update() {
        self.text = String(fruit.stock)
    }
}
