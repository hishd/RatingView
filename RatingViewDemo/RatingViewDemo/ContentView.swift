//
//  ContentView.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 04/01/2025.
//

import SwiftUI
import RatingView

struct ContentView: View {
    @State var isPresented: Bool = false
    @State var rating: Double = 0
    @State var feedback: String = ""
    
    var body: some View {
        RatingView(titleText: "How is our app experience?") { (rating: Double, feedback: String) in
            self.rating = rating
            isPresented.toggle()
        }
        .alert("Thank you", isPresented: $isPresented) {
            Button("OK") {
                isPresented = false
            }
        } message: {
            Text("Thank you for providing us with \(String(format: "%.1f", rating * 5)) out of 5.")
        }
    }
}

#Preview {
    ContentView()
}
