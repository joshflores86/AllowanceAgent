//
//  PaidView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 11/26/23.
//

import SwiftUI
import SwiftData

struct PaidView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.modelContext) var context
    @State var paid = false
    @Query var userPaid: [UserPaidModel]
    
    var body: some View {
        VStack{
            
            if userPaid.isEmpty /*viewModel.placeHolder.isEmpty*/ {
                EmptyView3()
            }else{
                List {
                    ForEach(/*viewModel.placeHolder*/userPaid, id: \.self) { user in
                        NavigationLink {
                            PaidReportView(userPaid: user)
                        } label: {
                            HStack {
                                Image(uiImage: /*UIImage(named: "default-avatar")!*/ user.avatarImage)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .overlay {Circle().stroke(lineWidth: 1.0)}
                                    .padding(.trailing)
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .lineLimit(1)
                                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                                    
                                    Text(user.amount)
                                }
                                Spacer()
                                VStack {
                                    Text("Date Paid")
                                    Text(user.paidDate)
                                }
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor( user.paid ? .green : .red)
                            }
                        }
                    }
//                    .onDelete(perform: { indexSet in
//                        for index in indexSet {
//                            context.delete(userPaid[index])
//                        }
//                    })
                }
                
            }
        }
    }
}

#Preview {
    PaidView()
        .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
                                                              name: "Josh",
                                                              amount: "",
                                                              avatarImageData: Data(),
                                                              initialValue: [""],
                                                              secondValue: [""],
                                                              valueHolder: [""],
                                                              steps: 0,
                                                              dueDate: "",
                                                              billsArray: ["":[""]])))}
