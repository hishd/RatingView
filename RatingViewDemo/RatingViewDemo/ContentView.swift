//
//  ContentView.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RatingView(titleText: "Do you enjoy our app?") { (rating: CGFloat, feedback: String) in
            
        }
    }
}

#Preview {
    ContentView()
}

struct RatingView: View {
    @State private var value: CGFloat = 0
    @State private var text: String = ""
    @FocusState private var isTextFocused: Bool
    var titleText: String
    var enableWrittenFeedback: Bool
    var onSubmit: (_ rating: CGFloat, _ feedback: String) -> Void
    
    init(titleText: String, enableWrittenFeedback: Bool = true, onSubmit: @escaping (_: CGFloat, _: String) -> Void) {
        self.titleText = titleText
        self.enableWrittenFeedback = enableWrittenFeedback
        self.onSubmit = onSubmit
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.frame(in: .local).width
            
            VStack {
                Text(titleText)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.top, 20)
                
                VStack {
                    HStack(spacing: 20) {
                        EyesExpression(lidValue: value)
                        EyesExpression(lidValue: value)
                    }
                    .padding(.top, 50 + 30) //Path curve height of eyes = 50
                    .padding(.bottom, ((1 - value) * 80))
                    
                    MouthExpressionShape(value: value)
                        .stroke(.black, lineWidth: 3)
                        .frame(height: 150)
                }
                
                Spacer()
                
//                ZStack(alignment: .leading) {
//                    Color.black
//                        .frame(width: width, height: 2)
//                    
//                    Image(systemName: "arrow.right")
//                        .foregroundStyle(.white)
//                        .frame(width: 50, height: 40)
//                        .background(.black)
//                        .clipShape(.rect(cornerRadius: 10))
//                        .offset(x: value * (width - 90))
//                        .gesture(DragGesture().onChanged({ drag in
//                            let maxWidth = width - 90
//                            let dragValue = drag.location.x - 30
//                            if dragValue > 0 && dragValue < maxWidth {
//                                self.value = dragValue / maxWidth
//                            }
//                        }))
//                    
//                }.padding(.horizontal, 20)
                
                if enableWrittenFeedback {
                    ZStack(alignment: .topLeading) {
                        if #available(iOS 16.0, *) {
                            TextEditor(text: $text)
                                .background(.white)
                                .foregroundStyle(.black)
                                .frame(height: 100)
                                .padding(.horizontal, 5)
                                .focused($isTextFocused)
                                .scrollContentBackground(.hidden)
                        } else {
                            List {
                                TextEditor(text: $text)
                                    .background(.white)
                                    .foregroundStyle(.black)
                                    .frame(height: 100)
                                    .focused($isTextFocused)
                                    .padding(.horizontal, 5)
                            }
                        }

                        Text("Write feedback")
                            .foregroundStyle(.gray)
                            .padding(.leading, 10)
                            .padding(.top, 10)
                            .opacity(isTextFocused ? 0 : 1)
                    }
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.vertical)
                    .padding(.horizontal, 20)
                }
                
                
                Button {
                    onSubmit(value, text)
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
            .frame(maxHeight: .infinity, alignment: .top)
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
