//
//  PaidReportView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 11/27/23.
//

import SwiftUI

struct PaidReportView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.modelContext) var context
    @State var userPaid: UserPaidModel
    
    
    var body: some View {
        VStack{
            List {
                Section(header: Text("Name")) {
                    Text(userPaid.name)
                        .paidReportFont()

                }
                Section(header: Text("Amount")) {
                    Text(userPaid.amount)
                        .paidReportFont()

                }
                Section(header: Text("Bills or Rewards")) {
                    ForEach(userPaid.initialValue.indices, id: \.self) { num in
                        HStack {
                            VStack(alignment: .leading){
                                Text(userPaid.initialValue[num])
                                    .font(.system(size: 20))
                                Text(userPaid.secondValue[num])
                                    .paidReportFont()
                            }
                            Spacer()
                            Text(userPaid.valueHolder[num])
                                .paidReportFont()

                        }
                    }
                }
                Section(header: Text("Due Date")){
                    Text(userPaid.dueDate)
                        .paidReportFont()
                }
                Section(header: Text("Date Paid")){
                    Text(userPaid.paidDate)
                        .paidReportFont()
                }
                Section(header: Text("Final Payment")) {
                    Text(userPaid.finalPayment)
                        .paidReportFont()
                }
                
                Section(header: Text("Paid?")) {
                    Text(userPaid.paid ? "Yes" : "No")
                        .paidReportFont()
                    
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    PaidReportView(userPaid: UserPaidModel(id: UUID(),
                                           name: "JOsh Flores",
                                           amount: "$2,000.00",
                                           avatarImageData: Data(),
                                           paid: true,
                                           initialValue: ["Bills", "Rewards"],
                                           secondValue: ["Phone", "Chores"],
                                           valueHolder: ["$200.00", "$300.00"], 
                                           finalPayment: "$1,500.00",
                                           steps: 2,
                                           dueDate: "2/23/2023", 
                                           paidDate: "01/20/2026",
                                           billsArray: ["":[""]]))
}
