//
//  PictureSelection.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 12/9/23.
//

import SwiftUI

struct PictureSelection: View {
    @EnvironmentObject var viewModel: DataViewModel
    
    
    var body: some View {
        VStack{
            
        }
    }
}

#Preview {
    PictureSelection()
        .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
                                                              name: "",
                                                              amount: "",
                                                              avatarImageData: Data(),
                                                              initialValue: [""],
                                                              secondValue: [""],
                                                              valueHolder: [""],
                                                              steps: 0,
                                                              dueDate: "",
                                                              billsArray: ["":[""]])))
    }

