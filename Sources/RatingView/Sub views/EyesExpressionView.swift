//
//  EyesExpressionView.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 08/01/2025.
//

import SwiftUI

struct EyesExpressionView: View {
    var lidValue: CGFloat
    
    var body: some View {
        ZStack {
            EyesShape()
                .stroke(.black, lineWidth: 3)
                .frame(width: 100, height: 100)
            
            EyesShape(value: lidValue)
                .stroke(.black, lineWidth: 3)
                .frame(width: 100, height: 100)
                .rotationEffect(.init(degrees: 180))
                .offset(y: -100)
            
            Circle()
                .fill(.black)
                .frame(width: 15)
                .offset(y: -20)
        }
    }
}
