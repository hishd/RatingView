//
//  RatingView.swift
//  Created by Hishara Dilshan on 08/01/2025.
//

import SwiftUI

public struct RatingView: View {
    @State private var value: CGFloat = 0
    @State private var text: String = ""
    @FocusState private var isTextFocused: Bool
    var titleText: String
    var enableWrittenFeedback: Bool
    var onSubmit: (_ rating: Double, _ feedback: String) -> Void
    
    public init(titleText: String, enableWrittenFeedback: Bool = true, onSubmit: @escaping (_: Double, _: String) -> Void) {
        self.titleText = titleText
        self.enableWrittenFeedback = enableWrittenFeedback
        self.onSubmit = onSubmit
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let width = proxy.frame(in: .local).width
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    titleView
                    
                    expressionView
                        .frame(height: 320)
                    
                    commentTitleView
                    
                    sliderView(of: width)
                        .padding(.horizontal, 20)
                    
                    if enableWrittenFeedback {
                        feedbackTextField
                    }
                    
                    
                    submitButton
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .background {
                backgroundColor
                .ignoresSafeArea(.all)
                .animation(.easeInOut, value: value)
            }
            .onTapGesture {
                isTextFocused = false
            }
        }
        
    }
}

extension RatingView {
    var commentTitle: String {
        switch value {
        case 0...0.2:
            "BAD"
        case 0.2...0.5:
            "REGULAR"
        case 0.5...0.8:
            "GOOD"
        default:
            "EXCELLENT"
        }
    }
    
    var backgroundColor: Color {
        switch value {
        case 0...0.2:
            Color.red
        case 0.2...0.5:
            Color.orange
        case 0.5...0.8:
            Color.yellow
        default:
            Color.green
        }
    }
}

extension RatingView {
    
    var titleView: some View {
        Text(titleText)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(.top, 20)
    }
    
    var expressionView: some View {
        VStack {
            HStack(spacing: 20) {
                EyesExpressionView(lidValue: value)
                EyesExpressionView(lidValue: value)
            }
            .padding(.top, 50 + 30) //Path curve height of eyes = 50
            .padding(.bottom, ((1 - value) * 80))
            
            MouthExpressionShape(value: value)
                .stroke(.black, lineWidth: 3)
        }
    }
    
    var commentTitleView: some View {
        Text(commentTitle)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
    }
    
    var feedbackTextField: some View {
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
                .opacity(text.count > 0 ? 0 : 1)
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.vertical)
        .padding(.horizontal, 20)
    }
    
    var submitButton: some View {
        Button {
            onSubmit(value, text)
        } label: {
            Text("Submit")
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .frame(width: 100, height: 40)
                .background(.black)
                .clipShape(.rect(cornerRadius: 5))
                .padding()
        }
    }
}

extension RatingView {
    func sliderView(of width: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            Color.black
                .frame(height: 2)
            
            Image(systemName: "arrow.right")
                .foregroundStyle(.white)
                .frame(width: 50, height: 40)
                .background(.black)
                .clipShape(.rect(cornerRadius: 10))
                .offset(x: value * (width - 90))
                .gesture(DragGesture().onChanged({ drag in
                    let maxWidth = width - 90
                    let dragValue = drag.location.x - 30
                    if dragValue > 0 && dragValue < maxWidth {
                        withAnimation {
                            self.isTextFocused = false
                            self.value = dragValue / maxWidth
                        }
                    }
                }))
            
        }
    }
}

