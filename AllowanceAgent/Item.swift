//
//  Item.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
