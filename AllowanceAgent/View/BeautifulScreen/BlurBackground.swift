//
//  BlurBackground.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/17/23.
//

import SwiftUI

struct BlurBackground: View {
    @State private var size = 1.3
    @State private var opacity = 1.0
    
    var body: some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .blur(radius: 5.0)
    }
}

#Preview {
    BlurBackground()
}
