//
//  UserModel.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import Foundation
import UIKit
import SwiftUI
import SwiftData

@Model
class UserModel: Identifiable {
    var id: UUID
    var notifID = UUID().uuidString
    var name: String
    var amount: String
    var avatarImageData: Data?
    var initialValue: [String]
    var secondValue: [String]
    var valueHolder: [String]
    var finalPayment: String
    var steps: Int = 0
    var dueDate: String
    var avatarImage: UIImage {
        get{
            guard let imageData = avatarImageData else {
                return UIImage(named: "default-avatar")!
            }
            return UIImage(data: imageData)!
        }set{
            avatarImageData = newValue.pngData()
        }
    }
    var billsArray: [String: [String]] = [
        "-": ["-"],
        "Bills": ["-","Electric", "Water", "Cable", "Internet", "Phone Bill", "Groceries", "Car Loan"],
        "Rewards": ["-","Good Grades", "Chores", "Good Behavior", "Birthday"]
    ]
    
    
    init(id: UUID, name: String, amount: String, avatarImageData: Data?, initialValue: [String], secondValue: [String], valueHolder: [String], finalPayment: String, steps: Int, dueDate: String, billsArray: [String : [String]]) {
        self.id = id
        self.name = name
        self.amount = amount
        self.avatarImageData = avatarImageData
        self.initialValue = initialValue
        self.secondValue = secondValue
        self.valueHolder = valueHolder
        self.finalPayment = finalPayment
        self.steps = steps
        self.dueDate = dueDate
        self.billsArray = billsArray
    }
    
}

@Model
class UserPaidModel: Identifiable {
    let id: UUID
    var name: String
    var amount: String
    var avatarImageData: Data?
    var paid: Bool
    var initialValue: [String]
    var secondValue: [String]
    var valueHolder: [String]
    var finalPayment: String
    var steps: Int = 0
    var dueDate: String
    var paidDate: String
    var avatarImage: UIImage {
        get{
            guard let imageData = avatarImageData else {
                return UIImage(named: "default-avatar")!
            }
            return UIImage(data: imageData)!
        }set{
            avatarImageData = newValue.pngData()
        }
    }
    var billsArray: [String: [String]] = [
        "-": ["-"],
        "Bills": ["-","Electric", "Water", "Cable", "Internet", "Phone Bill", "Groceries", "Car Loan"],
        "Rewards": ["-","Good Grades", "Chores", "Good Behavior", "Birthday"]
    ]
    
    init(id: UUID, name: String, amount: String, avatarImageData: Data?, paid: Bool, initialValue: [String], secondValue: [String], valueHolder: [String], finalPayment: String, steps: Int, dueDate: String, paidDate: String, billsArray: [String : [String]]) {
        self.id = id
        self.name = name
        self.amount = amount
        self.avatarImageData = avatarImageData
        self.paid = paid
        self.initialValue = initialValue
        self.secondValue = secondValue
        self.valueHolder = valueHolder
        self.finalPayment = finalPayment
        self.steps = steps
        self.dueDate = dueDate
        self.paidDate = paidDate
        self.billsArray = billsArray
    }
}




