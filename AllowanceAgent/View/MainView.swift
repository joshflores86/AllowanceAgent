//
//  MainView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @State var showEditUserView = false
    @State var userPaid = false
    @Query var users: [UserModel]
    
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    if /*viewModel.userModelPalcerHolder.isEmpty*/users.isEmpty{
                        TitleView()
                        
                        EmptyView()
                    }else{
                        TitleView()
                            .offset(y: 280)
                        List {
                            ForEach(/*viewModel.userModelPalcerHolder*/users, id: \.id) { user in
                                
                                NavigationLink {
                                    DetailView(viewModel: _viewModel, user: user)
                                    
                                } label: {
                                    HStack {
                                        Image(uiImage: /*UIImage(named: "default-avatar")!*/user.avatarImage)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                            .overlay {Circle().stroke(lineWidth: 1.0)}
                                            .padding(.trailing)
                                        VStack(alignment: .leading) {
                                            Text(user.name)
                                                .lineLimit(2)
                                                .minimumScaleFactor(0.9)
                                                .font(.system(size: 20, weight: .bold, design: .monospaced))
                                            Text(viewModel.calFinalPayment(user: user))
                                                .padding(.bottom, 1)
                                                .minimumScaleFactor(0.1)
                                        }
                                        Spacer()
                                        VStack{
                                            Text("Due Date")
                                                .font(.system(size: 17, weight:.bold))
                                            Text(user.dueDate)
                                                .font(.system(.callout, weight: .medium))
                                        }
                                    }
                                    
                                    
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                                    Button {
                                        self.showEditUserView = true
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }
                                })
                                .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                                    Button {
                                        let paidUser = UserPaidModel(id: UUID(),
                                                                     name: user.name,
                                                                     amount: user.amount,
                                                                     avatarImageData: user.avatarImage.pngData(),
                                                                     paid: true,
                                                                     initialValue: user.initialValue,
                                                                     secondValue: user.secondValue,
                                                                     valueHolder: user.valueHolder,
                                                                     finalPayment: user.finalPayment,
                                                                     steps: user.steps,
                                                                     dueDate: user.dueDate,
                                                                     paidDate: viewModel.todaysDate(),
                                                                     billsArray: user.billsArray)
                                        context.insert(paidUser)
                                        deleteFromContainer(index: users.firstIndex(where: {$0 == $0})!)
                                    } label: {
                                        Image(systemName: "dollarsign.square.fill")
                                    }
                                    .tint(.green)
                                })
                                .sheet(isPresented: $showEditUserView) {
                                    EditUserView(avatarImage: user.avatarImage, step: user.steps, users: user)
                                        .presentationDetents([.fraction(1.0)])
                                        .environmentObject(viewModel)
                                }
                            }
                            
                            .onDelete { indexSet in
                                for index in indexSet{
                                    context.delete(users[index])
                                }
                            }
                        }
                        
                        .offset(y: 15)
                        .opacity(0.7)
                        
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: PaidView()) {
                        Image(systemName: "doc.text.fill")
                            .tint(Color(uiColor: UIColor(named: "AllowanceColor")!))
                    }
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: EntryView(users: users)) {
                        Image(systemName: "plus")
                            .tint(Color(uiColor: UIColor(named: "TrackerColor")!))
                        
                    }
                }
            })
            
            .onAppear {
                NotificationManager().requestAuthorization()
                NotificationManager().removeBubble()
                if !users.isEmpty {
                    print(users[0].initialValue)
                }
                
            }
            .background {
                BlurBackground()
            }
            
        }
    }
    func deleteFromContainer(index: Int){
        
        context.delete(users[index])
        
    }
}

#Preview {
    
    MainView()
    
        .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
                                                              name: "Josh Flores",
                                                              amount: "$3,000.00",
                                                              avatarImageData: Data(),
                                                              initialValue: [""],
                                                              secondValue: [""],
                                                              valueHolder: [""], finalPayment: "",
                                                              steps: 0,
                                                              dueDate: "",
                                                              billsArray: ["":[""]])))
    
}
