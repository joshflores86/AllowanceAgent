//
//  EmptyView.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/17/23.
//

import SwiftUI

struct EmptyView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Text("Click '+' to add new person name and amount")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundColor(colorScheme == .dark ? Color("AllowanceColor") : Color.black)
                .multilineTextAlignment(.center)
                .opacity(0.5)
                
        }
    }
}

struct EmptyView2: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Text("No Bills or Rewards \n Have Been Given")
                .font(.system(size: 20, weight: .medium, design: .monospaced))
                .foregroundColor(colorScheme == .dark ? Color("AllowanceColor") : Color.black)
                .multilineTextAlignment(.center)
                .opacity(0.5)
                
        }
    }
}

struct EmptyView3: View {
    @EnvironmentObject var viewModel: DataViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Text("No History on \n Paid Users")
                .font(.system(size: 20, weight: .medium, design: .monospaced))
                .foregroundColor(colorScheme == .dark ? Color("AllowanceColor") : Color.black)
                .multilineTextAlignment(.center)
                .opacity(0.5)
                
        }
    }
}

#Preview {
    EmptyView3()
        
}
