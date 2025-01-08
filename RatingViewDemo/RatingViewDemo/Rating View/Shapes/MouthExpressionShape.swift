//
//  MouthExpressionShape.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 08/01/2025.
//

import SwiftUI

struct MouthExpressionShape: Shape {
    var value: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center: CGFloat = rect.width / 2
            
            let curveRadius: CGFloat = (200 * value) - 100
            
            path.move(to: .init(x: center - 150, y: 0))
            
            let firstPoint: CGPoint = .init(x: center, y: curveRadius)
            let firstControl1: CGPoint = .init(x: center - 145, y: 0)
            let firstControl2: CGPoint = .init(x: center - 145, y: curveRadius)
            
            let secondPoint: CGPoint = .init(x: center + 150, y: 0)
            let secondControl1: CGPoint = .init(x: center + 145, y: curveRadius)
            let secondControl2: CGPoint = .init(x: center + 145, y: 0)
            
            path.addCurve(to: firstPoint, control1: firstControl1, control2: firstControl2)
            path.addCurve(to: secondPoint, control1: secondControl1, control2: secondControl2)
        }
    }
}
