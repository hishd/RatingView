//
//  ContentView.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RatingView(titleText: "Do you enjoy our app?") {
            
        }
    }
}

#Preview {
    ContentView()
}

struct RatingView: View {
    @State var value: CGFloat = 1
    var titleText: String
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .padding(.top, 20)
            
            Spacer()
            
            HStack(spacing: 20) {
                EyesExpression(lidValue: value)
                EyesExpression(lidValue: value)
            }.padding(.bottom, ((1 - value) * 80))
            
            MouthExpressionShape(value: value)
                .stroke(.black, lineWidth: 3)
                .frame(height: 150)
            
            Slider(value: $value)
                .padding()
            
            Spacer()
            
            Button {
                onSubmit()
            } label: {
                Text("Submit")
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 100, height: 40)
            .background(.black)
            .clipShape(.rect(cornerRadius: 5))
            .padding()
        }
        .background {
            let color = switch value {
            case 0...0.3:
                Color.red
            case 0.3...0.7:
                Color.yellow
            default:
                Color.green
            }
            
            return color
                .ignoresSafeArea(.all)
                .animation(.easeInOut, value: value)
        }
    }
}

fileprivate struct MouthExpressionShape: Shape {
    
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


fileprivate struct EyesExpression: View {
    
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

fileprivate struct EyesShape: Shape {
    
    var value: CGFloat?
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center: CGFloat = rect.width / 2
            
            let curveRadius: CGFloat = 55 * (value ?? 1)
            
            path.move(to: .init(x: center - 50, y: 0))
            
            let firstPoint: CGPoint = .init(x: center, y: curveRadius)
            let firstControl1: CGPoint = .init(x: center - 50, y: 0)
            let firstControl2: CGPoint = .init(x: center - 50, y: curveRadius)
            
            let secondPoint: CGPoint = .init(x: center + 50, y: 0)
            let secondControl1: CGPoint = .init(x: center + 50, y: curveRadius)
            let secondControl2: CGPoint = .init(x: center + 50, y: 0)
            
            path.addCurve(to: firstPoint, control1: firstControl1, control2: firstControl2)
            path.addCurve(to: secondPoint, control1: secondControl1, control2: secondControl2)
        }
    }
}
