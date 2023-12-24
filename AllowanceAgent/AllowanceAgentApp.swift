//
//  AllowanceAgentApp.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import SwiftUI
import SwiftData

@main
struct AllowanceAgentApp: App {
    var mainModelContainer: ModelContainer = {
        let schema = Schema([
            UserModel.self, UserPaidModel.self

        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SplashScreen(viewModel: DataViewModel(usersInfo: UserModel(id: UUID(),
                                                                       name: "",
                                                                       amount: "",
                                                                       avatarImageData: Data(), 
                                                                       initialValue: [""],
                                                                       secondValue: [""],
                                                                       valueHolder: [""],
                                                                       finalPayment: "",
                                                                       steps: 0,
                                                                       dueDate: "",
                                                                       billsArray: ["":[""]])))
            .onAppear{
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
        .modelContainer(mainModelContainer)    }
}
