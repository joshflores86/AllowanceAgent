//
//  PictureSelection.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 12/9/23.
//

import SwiftUI

struct PictureSelection: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage
    
    var body: some View {
        VStack(alignment: .center){
            List{
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(viewModel.animatedProfilePic, id: \.self) { pic in
                        Image(pic)
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                selectedImage = UIImage(named: pic)!
                                print(selectedImage)
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                
            }
        }
        
        .environmentObject(viewModel)
    }
}

#Preview {
    @State var image: UIImage = UIImage(named: "default-avatar")!
    
   return PictureSelection(selectedImage: $image)
    
        .environmentObject(DataViewModel(usersInfo: UserModel(id: UUID(),
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
    }

