//
//  DataViewModel.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//


import Foundation
import UIKit
import SwiftUI
import SwiftData

class DataViewModel: ObservableObject {
    
    @Published var usersInfo: UserModel
    @Published var usersInfoArray: [UserModel] = []
    @Published var billsArray: [String: [String]] = [
        "-": ["-"],
        "Bills": ["-","Electric", "Water", "Cable", "Internet", "Phone Bill", "Groceries", "Car Loan"],
        "Rewards": ["-","Good Grades", "Chores", "Good Behavior", "Birthday"]
    ]
    @Published var billsArrayToSave: [String: [String]] = [
        "-": ["-"],
        "Bills": ["-","Electric", "Water", "Cable", "Internet", "Phone Bill", "Groceries", "Car Loan"],
        "Rewards": ["-","Good Grades", "Chores", "Good Behavior", "Birthday"]
    ]
    @Environment(\.modelContext) var context
    @Published var firstValue = Array(repeating: "-", count: 50)
    @Published var secondValue = Array(repeating: "-", count: 50)
    @Published var valuePlacer = Array(repeating: "", count: 50)
    @Published var steps = 0
    @Published var showAmountAlert = false
    @Published var showBillAlert = false
    @Published var showMissingNameAlert = false
    @Published var showMissingAmountAlert = false
    @Published var showCustomTextAlert = false
    @Published var hideButton: Bool = false
    @Published var animatedProfilePic: Array = [
        Image("Boy_Pic"), Image("Boy_Pic2"), Image("Boy_Pic3")
    ]
    @Published var valueHolder: String = ""
    @Published var userModelPalcerHolder = [
        UserModel(id: UUID(),
                      name: "JOsh Flores",
                      amount: "$2,000.00",
                      avatarImageData: Data(),
                      initialValue: ["Bills", "Bills"],
                      secondValue: ["Phone", "Car Loan"],
                      valueHolder: ["$200.00", "$300.00"],
                      steps: 2,
                      dueDate: "2/23/2023",
                      billsArray: ["":[""]]) ,
        UserModel(id: UUID(),
                      name: "Briana Caraballo",
                      amount: "$5,000.00",
                      avatarImageData: Data(),
                      initialValue: ["Bills", "Bills"],
                      secondValue: ["Phone", "Car Loan"],
                      valueHolder: ["$800.00", "$300.00"],
                      steps: 2,
                      dueDate: "2/23/2023",
                      billsArray: ["":[""]])
        
    ]
    @Published var placeHolder = [
        UserPaidModel(id: UUID(),
                      name: "JOsh Flores",
                      amount: "$2,000.00",
                      avatarImageData: Data(),
                      paid: false,
                      initialValue: ["Bills", "Bills"],
                      secondValue: ["Phone", "Car Loan"],
                      valueHolder: ["$200.00", "$300.00"],
                      finalPayment: "$1,500.00",
                      steps: 2,
                      dueDate: "2/23/2023",
                      paidDate: "12/25/2023",
                      billsArray: ["":[""]]) ,
        UserPaidModel(id: UUID(),
                      name: "Briana Caraballo",
                      amount: "$5,000.00",
                      avatarImageData: Data(),
                      paid: true,
                      initialValue: ["Bills", "Bills"],
                      secondValue: ["Phone", "Car Loan"],
                      valueHolder: ["$800.00", "$300.00"],
                      finalPayment: "$3,900.00",
                      steps: 2,
                      dueDate: "2/23/2023", 
                      paidDate: "01/20/2025",
                      billsArray: ["":[""]])
        
    ]
    
    init(usersInfo: UserModel){
        self.usersInfo = usersInfo
        
    }
    
    func saveInfo(name: String, amount: String, selectImage: UIImage, steps: Int, dueDate: String) {
        //        usersInfoArray.append(UserModel(id: UUID(), name: name, amount: amount, avatarImageData: selectImage.pngData(), initialValue: firstValue, secondValue: secondValue, valueHolder: valuePlacer, steps: steps, dueDate: dueDate, billsArray: usersInfo.billsArray))
        
        
    }
    
    
    
    //MARK: - App Storage code
    
    //    private var documentDirectory: URL {
    //        get{
    //            try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    //        }
    //    }
    //    private var notesFile: URL {
    //        documentDirectory.appendingPathComponent("usersInfo").appendingPathExtension(for: .json)
    //    }
    //
    //    func save() throws {
    //        let data = try JSONEncoder().encode(usersInfoArray)
    //        try data.write(to: notesFile)
    //        print("Saved")
    //    }
    //    func load() throws {
    //        guard FileManager.default.isReadableFile(atPath: notesFile.path) else {return}
    //        let data = try Data(contentsOf: notesFile)
    //        usersInfoArray = try JSONDecoder().decode([UserModel].self, from: data)
    //        print("Loaded")
    //    }
    //
    //MARK: - Function adding values
    
    func sumOfBills(user: UserModel) -> Double {
        var finalPay = 0.00
        if !user.valueHolder.isEmpty {
            let addition = user.initialValue.indices.filter({user.initialValue[$0] == "Bills"})
            let subtract = user.initialValue.indices.filter({user.initialValue[$0] == "Rewards"})
            
            for i in addition{
                let noCommaBills = user.valueHolder[i].replacingOccurrences(of: ",", with: "")
                let noCommaOr$ = noCommaBills.replacingOccurrences(of: "$", with: "")
                finalPay += Double(noCommaOr$) ?? 0.00
            }
            for i in subtract {
                let noCommaRewards = user.valueHolder[i].replacingOccurrences(of: ",", with: "")
                let noCommaOr$ = noCommaRewards.replacingOccurrences(of: "$", with: "")
                finalPay -= Double(noCommaOr$) ?? 0.00
            }
            print(finalPay)
        }
        return finalPay
    }
    
    func removing$AndComma(user: UserModel) -> Double {
        var perfectNum = 0.00
        let noComma = user.amount.replacingOccurrences(of: ",", with: "")
        if let noCommaOr$ = Double(noComma.replacingOccurrences(of: "$", with: "")) {
            perfectNum = noCommaOr$
        }
        return perfectNum
    }
    
    func calFinalPayment(user: UserModel) -> String {
        var modifiedAmount = 0.0
        var modifiedAmount2 = 0.00
        var finalPay = ""
        modifiedAmount += sumOfBills(user: user)
        modifiedAmount2 += removing$AndComma(user: user)
        let formattedAmount = modifiedAmount2 - modifiedAmount
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        if let formattedString = formatter.string(for: formattedAmount){
            finalPay = formattedString
        }
        return finalPay
    }
    
    func addValueToArray(steps: Int) {
        valuePlacer = valuePlacer.filter {$0 != ""}
        print(valuePlacer)
        secondValue = secondValue.filter {$0 != "-"}
        print(secondValue)
        firstValue = firstValue.filter {$0 != "-"}
        print(firstValue)
        for _ in 0..<steps {
            firstValue.append("-")
            secondValue.append("-")
            valuePlacer.append("-")
        }
        
    }
    
   /* func cleanUpArray(value: [UserModel]) {
        
        for item in value.indices {
            
        }
        
    }*/
    
    func deleteFromContainer(index: IndexSet, user: [UserModel]){
        for num in index{
            context.delete(user[num])
        }
    }
    
    func changeToCurrencyValue(value: String) -> String {
        var modifiedValue = ""
        let filtered = value.filter {"1234567890".contains($0)}
        if let givenAmount = Int(filtered) {
            let decimalAmount = Double(givenAmount) / 100.0
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "USD"
            formatter.currencySymbol = "$"
            if let formattedString = formatter.string(from: NSNumber(value: decimalAmount)){
                modifiedValue = formattedString
            }
        }
        return modifiedValue
    }
    
    
    func addingCurrencySym(value: String) -> String {
        var finalPayment = ""
        if let num = Double(value) {
            let format = NumberFormatter()
            format.numberStyle = .currency
            format.currencyCode = "USD"
            format.currencySymbol = "$"
            if let finalFormat = format.string(from: num as NSNumber){
                finalPayment = finalFormat
            }
        }
        return finalPayment
    }
    
    
    func dismissKeyboard() {
        //        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
    
    //MARK: - Custom Bills and Rewards function
    
    func customBill(bill: String){
        usersInfo.billsArray["Bills"]?.append(bill)
    }
    
    func customReward(reward: String) {
        usersInfo.billsArray["Rewards"]?.append(reward)
    }
    
    
    //MARK: - Function for updating users info
    
    
    
    func saveUpdatedUserInfo(index: Array<UserModel>.Index, name: String, amount: String, image: UIImage, dueDate: String) {
        print(index)
        usersInfoArray[index].amount = amount
        usersInfoArray[index].name = name
        usersInfoArray[index].avatarImage = image
        usersInfoArray[index].dueDate = dueDate
        
        //        try? save()
        
    }
    
    
//    func saveUpdatedBillsRewards(index: Array<UserModel>.Index, firstValue: [String], secondValue: [String], mainValue: [String], steps: Int) {
//        usersInfoArray[index].initialValue.removeAll()
//        usersInfoArray[index].secondValue.removeAll()
//        usersInfoArray[index].valueHolder.removeAll()
//        usersInfoArray[index].steps = steps
//        for i in firstValue{
//            if i != "-" {
//                usersInfoArray[index].initialValue.insert(i, at: 0)
//            }
//        }
//        print(usersInfoArray[index].initialValue)
//        for i in secondValue{
//            if i != "-" {
//                usersInfoArray[index].secondValue.insert(i, at: 0)
//            }
//        }
//        print(usersInfoArray[index].secondValue)
//        for i in mainValue{
//            if i != "-" {
//                usersInfoArray[index].valueHolder.insert(i, at: 0)
//            }
//        }
//        print(usersInfoArray[index].valueHolder)
//        //        try? save()
//    }
    
    
    func todaysDate() -> String {
        let today = Date()
        let formatDate = DateFormatter()
        formatDate.string(from: today)
        formatDate.dateStyle = .short
        return formatDate.string(from: today)
    }
    
    
    
    
    //MARK: - Alert Functions
    
    func getAlert() -> Alert  {
        if showMissingNameAlert {
            return Alert(title: Text("Missing Users Name"), message: Text("Please enter name"))
        } else if showMissingAmountAlert {
            return Alert(title: Text("Missing Amount"), message: Text("Please enter users amount"))
        } else if showBillAlert {
            return Alert(title: Text("Missing Bill and Amount"), message: Text("Please add the type of bill or reward and the amount"))
        } else if showAmountAlert {
            return Alert(title: Text("Missing Amount"), message: Text("Please enter amount value"))
        } else {
            return Alert(title: Text(""), message: Text(""))
        }
    }
    
    
    func showAlert(name: String, amount: String) {
        showMissingNameAlert = false
        showMissingAmountAlert = false
        showBillAlert = false
        showAmountAlert = false
        if name == ""{
            showMissingNameAlert = true
        }else if amount == "" {
            showMissingAmountAlert = true
        }else if firstValue.isEmpty || secondValue.isEmpty {
            showBillAlert = true
        }else if valuePlacer.isEmpty {
            showAmountAlert = true
        }else{
            print("Everything worked fine")
        }
    }
    
    
    
    //MARK: - ActionSheet Alert function
    
//    func confirmBillRewardsActionSheet(index: Array<UserModel>.Index,firstValue: [String],
//                                       secondValue: [String], mainValue: [String], steps: Int) -> ActionSheet {
//        
//        let saveButton: ActionSheet.Button = .default(Text("Save")) {
//            self.saveUpdatedBillsRewards(index: index,
//                                         firstValue: firstValue,
//                                         secondValue: secondValue,
//                                         mainValue: mainValue,
//                                         steps: steps)
//        }
//        return ActionSheet(title: Text("Bills and Rewards"), message: Text("Are you sure you want to save?"), buttons: [saveButton, .cancel()])
//    }
//    
//    func confirmUserEditActionSheet(index: Array<UserModel>.Index, userName: String,
//                                    userAmount: String, avatarImage: UIImage, dueDate: String) -> ActionSheet {
//        
//        let saveButton: ActionSheet.Button = .default(Text("Save")) {
//            self.saveUpdatedUserInfo(index: index,
//                                     name: userName,
//                                     amount: userAmount,
//                                     image: avatarImage,
//                                     dueDate: dueDate)
//        }
//        return ActionSheet(title: Text("User Info"), message: Text("Are you sure you want to save?"), buttons: [saveButton, .cancel()])
//    }
//    
        
    
    
    
}
