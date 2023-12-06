//
//  Extension.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//


import Foundation
import SwiftUI

extension Text {
    func titleStyleLeft() -> some View {
        self.font(Font.custom("Lobster-Regular", size: 48))
            .navigationBarTitleDisplayMode(.large)
//            .padding(.top)
            .foregroundColor(Color("AllowanceColor"))
    }
    
    func titleStyleRight() -> some View {
        self.font(Font.custom("Lobster-Regular", size: 48))
            .navigationBarTitleDisplayMode(.large)
//            .padding(.top)
            .foregroundColor(Color("TrackerColor"))
    }
    
    func trackerColor() -> some View {
        self.foregroundColor(Color("TrackerColor"))
    }
    
    func allowanceColor() -> some View {
        self.foregroundColor(Color("AllowanceColor"))
    }
    
    func paidReportFont() -> some View {
        self.font(.system(size: 20, weight: .bold))

    }
}


    

