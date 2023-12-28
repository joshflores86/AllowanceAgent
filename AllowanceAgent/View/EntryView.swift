//
//  EntryView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/19/23.
//

import SwiftUI
import SwiftData

struct EntryView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    @State var name = ""
    @State var amount = ""
    @State var avatarImage = UIImage(named: "default-avatar")!
    @State var step = 0
    @State var newPhoto: Bool = false
    @State var cameraIsSelected: Bool = false
    @State var showAnimatedPic: Bool = false
    @State var showConfirmation = false
    @State var imageSelector: Bool = false
    @State var showCustomBillAlert = false
    @State var customBill = ""
    @State var customReward = ""
    @State var showCustomRewardAlert = false
    @State var customConfirmation = false
    @State var selectedDate = Date()
//    @State var dueTime = ""
    @State var users: [UserModel]
    @FocusState var dismissKeyboard: Bool
    var formattedTimes: String {
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .minute, value: 5, to: selectedDate)
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        return timeFormat.string(from: newDate ?? selectedDate) 
    }
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
                        Image(uiImage: avatarImage)
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
                        
                        TextField("Enter Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .focused($dismissKeyboard)
                        TextField("Enter Amount", text: $amount)
                            .textFieldStyle(.roundedBorder)
                            .focused($dismissKeyboard)
                            .keyboardType(.decimalPad)
                            .onChange(of: amount) {
                                amount = viewModel.changeToCurrencyValue(value: amount)
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
                        
                        HStack {
                            if step >= 1 {
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
                            Stepper("", value: $step, in: 0...25){ _ in print(step)}
                                .padding(.trailing, 20)
                        }
                        .padding([.top], 30)
                        .padding([.bottom], 10)
                    }
                    
                    ForEach(0..<step, id: \.self) { num in
                        HStack {
                            VStack{
                                Picker("", selection: $viewModel.firstValue[num]) {
                                    ForEach(viewModel.billsArrayToSave.keys.sorted(), id: \.self) { bills in
                                        Text(bills)
                                    }
                                }
                                if viewModel.firstValue[num] != "-" {
                                    Picker("", selection: $viewModel.secondValue[num]) {
                                        ForEach(viewModel.billsArrayToSave[viewModel.firstValue[num]]!, id: \.self) { value in
                                            Text(value)
                                        }
                                    }
                                }else{
                                    
                                }
                            }
                            TextField("Enter Amount", text: $viewModel.valuePlacer[num])
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($dismissKeyboard)
                                .onChange(of: viewModel.valuePlacer[num]) {
                                    viewModel.valuePlacer[num] = viewModel.changeToCurrencyValue(value: viewModel.valuePlacer[num])
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
                        customReward = ""
                        showCustomRewardAlert = false
                    }else{
                        showCustomRewardAlert = false
                    }
                }
            })
            .alert(isPresented: getAlertBinding(), content: {
                viewModel.getAlert()
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
               //MARK: - Left off here... trying to setup picture selection
                    
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
            .sheet(isPresented: $showAnimatedPic, content: {
                PictureSelection(selectedImage: $avatarImage)
                    .presentationDetents([.fraction(0.75)])
                    .environmentObject(viewModel)
            })
            .sheet(isPresented: $imageSelector, content: {
                ImagePicker(image: $avatarImage, isCameraSelected: $cameraIsSelected)
                    
                
            })
            .confirmationDialog("Please Confirm", isPresented: $showConfirmation) {
                Button("Save") {
                    viewModel.addValueToArray(steps: step)
                    viewModel.showAlert(name: name, amount: amount)
                    if !viewModel.showMissingNameAlert &&
                        !viewModel.showMissingAmountAlert &&
                        !viewModel.showBillAlert && !viewModel.showAmountAlert  {
                        
                        let user = UserModel(id: UUID(), name: name, amount: amount, avatarImageData: avatarImage.pngData(), initialValue: viewModel.firstValue, secondValue: viewModel.secondValue, valueHolder: viewModel.valuePlacer, finalPayment: "", steps: step, dueDate: formattedDate, billsArray: viewModel.billsArrayToSave)
                        context.insert(user)
                        
                        NotificationManager().scheduleNotification(dueDate: formattedDate, dueTime: formattedTimes, name: name, user: user)
                        presentationMode.wrappedValue.dismiss()
                    }
                    viewModel.firstValue = Array(repeating: "-", count: 50)
                    viewModel.secondValue = Array(repeating: "-", count: 50)
                    viewModel.valuePlacer = Array(repeating: "", count: 50)
                    
                    
                }
                
            } message: {
                Text("Are you sure you want to save?")
            }
        }
        .environmentObject(viewModel)
    }
    func getAlertBinding() -> Binding<Bool> {
        if viewModel.showMissingNameAlert{
            return $viewModel.showMissingNameAlert
        }else if viewModel.showMissingAmountAlert {
            return $viewModel.showMissingAmountAlert
        }else if viewModel.showBillAlert {
            return $viewModel.showBillAlert
        }else if viewModel.showAmountAlert {
            return $viewModel.showAmountAlert
        }else{
            return Binding.constant(false)
        }
        
    }
    
}

#Preview {
    EntryView(users: [UserModel(id: UUID(),
                                name: "",
                                amount: "",
                                avatarImageData: Data(),
                                initialValue: [""],
                                secondValue: [""],
                                valueHolder: [""], finalPayment: "",
                                steps: 0,
                                dueDate: "",
                                billsArray: ["":[""]])])
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
