//
//  DetailView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/19/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.modelContext) var context
    @State var user: UserModel
    @State var finalAmount = "0.00"
    private let leftSideColor = UIColor(named: "AllowanceColor")
    private let rightSideColor = UIColor(named: "TrackerColor")

  
    
    
    var index: Array<UserModel>.Index {
        viewModel.usersInfoArray.firstIndex(where: {$0.id == self.id("Identifier") as? UUID}) ?? 0
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text(user.name)
                    .font(.system(size: 35, weight: .heavy, design: .monospaced))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding(.bottom, 20)
                    .offset(y: -30)
                
                Image(uiImage: /*UIImage(named: "default-avatar")!*/user.avatarImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 175, height: 175, alignment: .center)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1.0))
                    .offset(y: -30)
                
                HStack {
                    Text("Payment Due:")
                    
                    Spacer()
                    Text(user.dueDate)
                    
                }
                .padding([.bottom, .leading, .trailing], 15)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                
                HStack{
                    VStack {
                        Text("Amount")
                            .font(.system(size: 20, weight: .heavy, design: .monospaced))
                        Text(user.amount)
                            .font(.system(size: 26, weight: .medium, design: .monospaced))
                            .padding(.leading)
                    }
                    .foregroundStyle(Color(leftSideColor!))
                    Spacer()
                    VStack{
                        Text("Final Pay")
                            .font(.system(size: 20, weight: .heavy, design: .monospaced))
                        Text(finalAmount)
                            .font(.system(size: 26, weight: .medium, design: .monospaced))
                    }
                    .foregroundStyle(Color(rightSideColor!))
                    .padding(.trailing, 10)
                }
                Spacer()
                    List {
                        ForEach(0..<user.initialValue.count) { num in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(user.initialValue[num])
                                    Text(user.secondValue[num])
                                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                                }
                                .foregroundStyle(Color(leftSideColor!))
                                .frame(alignment: .leading)
                                Spacer()
                                
                                Text(user.valueHolder[num])
                                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color(rightSideColor!))
                            }
                        }
                    }
            }
            .onAppear{
                finalAmount = viewModel.calFinalPayment(user: user)
                user.finalPayment = finalAmount
                
            }
            .background {
                BlurBackground()
            }
        }
    }
}

#Preview {
    
    
    DetailView(user: UserModel(id: UUID(),
                                name: "Josh Flores",
                                amount: "$2,000.00",
                                avatarImageData: Data(),
                               initialValue: ["Bills", "Bills"],
                               secondValue: ["Phone", "Car Loan"],
                               valueHolder: ["$200.00", "$300.00"],
                               finalPayment: "",
                                steps: 2,
                                dueDate: "02/23/2023",
                                billsArray: ["":[""]]))
    .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
                                                          name: "",
                                                          amount: "",
                                                          avatarImageData: Data(),
                                                          initialValue: [""],
                                                          secondValue: [""],
                                                          valueHolder: [""], finalPayment: "",
                                                          steps: 0,
                                                          dueDate: "",
                                                          billsArray: ["":[""]])))
}
