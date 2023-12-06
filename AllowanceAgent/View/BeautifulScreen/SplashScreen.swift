//
//  SplashScreen.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(\.modelContext)var context
    @StateObject var viewModel: DataViewModel
    @State private var isActive: Bool = false
    @State private var size = 1.0
    @State private var opacity = 0.5
    

    
    var body: some View {
        if isActive {
            MainView(/*users: [UserModel(id: UUID(),
                                        name: "",
                                        amount: "",
                                        initialValue: [],
                                        secondValue: [],
                                        valueHolder: [],
                                        steps: 0,
                                        dueDate: "",
                                        billsArray: ["":[""]])]*/)
                .environmentObject(viewModel)
        }else{
            ZStack {
                VStack{
                    Image(uiImage: UIImage(named: "Applogo")!)
                        .resizable()
                        .clipShape(Circle())

                        .frame(width: 300, height: 300, alignment: .center )

                    VStack {
                        Text("Allowance")
                            .titleStyleLeft()
                        Text("AGENT")
                            .titleStyleRight()
                            
                    }
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        size = 1.3
                        opacity = 1.0
                    }
                })
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActive = true
                    }
                })
            }
            
        }
               
    }
}

#Preview {
     
    
    SplashScreen(viewModel: DataViewModel(usersInfo: UserModel(id: UUID(),
                                                               name: "",
                                                               amount: "",
                                                               avatarImageData: Data(),
                                                               initialValue: [],
                                                               secondValue: [],
                                                               valueHolder: [],
                                                               steps: 0,
                                                               dueDate: "", 
                                                               billsArray: ["":[""]])))
}
