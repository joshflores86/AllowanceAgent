//
//  ImagePicker.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import Foundation
import SwiftUI
import UIKit



  
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage
        @Binding var isCameraSelected: Bool
        @Environment(\.presentationMode) var presentationMode
        
        
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.allowsEditing = true
            picker.sourceType = isCameraSelected ? .camera : .photoLibrary
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            // Do nothing
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(photoPicker: self)
        }
    
        //MARK: - Class Coordinator
        
      final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let photoPicker: ImagePicker
                
            init(photoPicker: ImagePicker){
                self.photoPicker = photoPicker
            }
                
                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    if let image = info[.editedImage] as? UIImage {
                        photoPicker.image = image
                        
                    }else{
                        
                    }
                    picker.dismiss(animated: true)
                }
        
//                func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//                    parent.presentationMode.wrappedValue.dismiss()
//                }
            }
        }
    
    



