//
//  EditUserView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 11/8/23.
//

import SwiftUI

struct EditUserView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    
    @State var avatarImage: UIImage
    @State var step: Int
    @State var newPhoto: Bool = false
    @State var cameraIsSelected: Bool = false
    @State var showAnimatedPic: Bool = false
    @State var showConfirmation = false
    @State var imageSelector: Bool = false
    @State var showCustomBillAlert = false
    @State var customBill: String = ""
    @State var customReward: String = ""
    @State var showCustomRewardAlert = false
    @State var customConfirmation = false
    @State var selectedDate = Date()
    @State var dueTime: String = "20:00"
    @FocusState var dismissKeyboard: Bool
    @State var users: UserModel
    var formattedDate: String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        return dateFormat.string(from: selectedDate)
    }
    

    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    
                    VStack {
                        Image(uiImage: users.avatarImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .background(Color.black)
                            .clipShape(Circle())
                            .overlay {Circle().stroke(lineWidth: 1.0)}
                            .padding(.bottom, 10)
                            .onTapGesture {
                                newPhoto = true
                                print("Works")
                            }
                        
                        TextField("Enter Name", text: $users.name)
                            .textFieldStyle(.roundedBorder)
                        TextField("Enter Amount", text: $users.amount)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .focused($dismissKeyboard)
                            .onChange(of: users.amount) {
                                users.amount = viewModel.changeToCurrencyValue(value: users.amount)
                            }
                    }
                    .padding()
                    .position(x: 200, y: 160)
                    
                    VStack{
                        HStack {
                            Text("Select payment Date")
                            Spacer()
                            DatePicker("",
                                       selection: $selectedDate,
                                       in: Date()...,
                                       displayedComponents: .date)
                        }
                        .padding([.leading, .trailing, .top], 10)
                        .onAppear{
                            print(users.steps)
                        }
                        HStack {
                            if users.steps >= 1 {
                                Button("", systemImage: "dollarsign.circle", action: {
                                    showCustomBillAlert = true
                                })
                                .foregroundStyle(Color(uiColor: UIColor(named: "AllowanceColor")!))
                                .font(.system(size: 30))
                                .padding([.leading,.trailing], 20)
                                Button("", systemImage: "gift.fill", action: {
                                    showCustomRewardAlert = true
                                })
                                .foregroundStyle(Color(uiColor: UIColor(named: "TrackerColor")!))
                                .font(.system(size: 25))
                            }
                            
                            Spacer()
                            Stepper("", value: $users.steps, in: 0...25){ _ in
                                print(users.steps)
                                if users.steps > users.initialValue.count {
                                    users.initialValue.append("-")
                                    users.secondValue.append("-")
                                    users.valueHolder.append("-")
                                }else if users.steps < users.initialValue.count{
                                    users.initialValue.removeLast()
                                    users.secondValue.removeLast()
                                    users.valueHolder.removeLast()
                                }
                            }
                                .padding(.trailing, 20)
                                
                        }
                        .padding([.top], 30)
                        .padding([.bottom], 10)
                        
                    }
                   
                    ForEach(0..<users.steps, id: \.self) { num in
                        HStack {
                            VStack{
                                Picker("", selection: $users.initialValue[num]) {
                                    ForEach(users.billsArray.keys.sorted(), id: \.self) { bills in
                                        Text(bills)
                                    }
                                }
                                if users.initialValue[num] != "" {
                                    Picker("", selection: $users.secondValue[num]) {
                                        ForEach(users.billsArray[users.initialValue[num]]!, id: \.self) { value in
                                            Text(value)
                                        }
                                    }
                                }else{
                                    
                                }
                            }
                            TextField("Enter Amount", text: $users.valueHolder[num])
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($dismissKeyboard)
                                .onChange(of: users.valueHolder[num]) {
                                    users.valueHolder[num] = viewModel.changeToCurrencyValue(value: users.valueHolder[num])
                                }
                        }
                        .padding([.leading, .trailing], 20)
                    }
                    .position(x: 180, y: 20)
                    
                }
            }
            .alert("💲Add Custom Bill💲", isPresented: $showCustomBillAlert, actions: {
                TextField("Enter Custom Bill", text: $customBill)

                Button("Save") {
                    print(viewModel.usersInfo.billsArray)
                    if customBill != "" {
                        viewModel.billsArrayToSave["Bills"]?.append(customBill)
                        customBill = ""
                        showCustomBillAlert = false
                    }else{
                        showCustomBillAlert = false
                    }
                }
            })
            .alert("💸Add Custom Reward💸", isPresented: $showCustomRewardAlert, actions: {
                TextField("Enter Custom Bill", text: $customReward)

                Button("Save") {
                    if customReward != "" {
                        viewModel.billsArrayToSave["Rewards"]?.append(customReward)
                        showCustomRewardAlert = false
                    }else{
                        showCustomRewardAlert = false
                    }
                }
            })
            .alert("Camera 📷, Photo Library 🌁, Person 🙋🏼‍♂️ ", isPresented: $newPhoto, actions: {
                HStack{
                    
                    Button("Camera") {
                        cameraIsSelected = true
                        imageSelector = true
                    }
                    Button("Photo Library ") {
                        imageSelector = true
                        cameraIsSelected = false
                    }
                    Button("Avatar") {
                        showAnimatedPic = true
                    }
                }
            })
           
            
            .background(BlurBackground())
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        Spacer()
                        Button("Done") {
                            dismissKeyboard = false
                        }
                    }
                   
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Save") {
                        showConfirmation = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .accentColor(Color("TrackerColor"))
                    .foregroundColor(Color("AllowanceColor"))
                    .font(.title2)
                }
            }
            .sheet(isPresented: $showAnimatedPic, onDismiss:  {
                print("GoodBye")
                users.avatarImage = avatarImage
            }){
                PictureSelection(selectedImage: $avatarImage)
                    .presentationDetents([.fraction(0.75)])
                    .environmentObject(viewModel)
            }
            .sheet(isPresented: $imageSelector, content: {
                ImagePicker(image: $users.avatarImage, isCameraSelected: $cameraIsSelected)
            })
            .confirmationDialog("Please Confirm", isPresented: $showConfirmation) {
                Button("Save") {
                    users.dueDate = formattedDate
                    
//                    users.initialValue = users.initialValue.filter {$0 != "-"}
//                    users.secondValue = users.secondValue.filter {$0 != "-"}
//                    users.valueHolder = users.valueHolder.filter {$0 != "-"}
                    
                    
                    try? context.save()
                    NotificationManager().scheduleNotification(dueDate: formattedDate, dueTime: dueTime, name: users.name, user: users)
                    presentationMode.wrappedValue.dismiss()
                }
                
            } message: {
                Text("Are you sure you want to save?")
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    
    
    
    return EditUserView(avatarImage: UIImage(systemName: "default-avatar")!,
                 step: 0,
                 customBill: "",
                 customReward: "",
                 selectedDate: Date(),
                 users: UserModel(id: UUID(),
                                  name: "",
                                  amount: "",
                                  avatarImageData: Data(),
                                  initialValue: ["Bills"],
                                  secondValue: ["Phone"],
                                  valueHolder: ["100.00"],
                                  finalPayment: "",
                                  steps: 0,
                                  dueDate: "",
                                  billsArray: ["":[""]]) )
        .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
                                                              name: "",
                                                              amount: "",
                                                              avatarImageData: Data(),
                                                              initialValue: ["Bills"],
                                                              secondValue: ["Phone"],
                                                              valueHolder: ["100.00"],
                                                              finalPayment: "",
                                                              steps: 0,
                                                              dueDate: "",
                                                              billsArray: ["":[""]])))
}
