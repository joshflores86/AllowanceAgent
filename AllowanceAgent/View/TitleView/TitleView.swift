//
//  TitleView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/18/23.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Allowance")
                        .titleStyleLeft()
                    Text("Agent")
                        .titleStyleRight()
                }
            }
            .offset(y: -350)

        }
        
    }
}

#Preview {
    TitleView()
}
