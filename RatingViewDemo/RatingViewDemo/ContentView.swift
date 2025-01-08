//
//  ContentView.swift
//  RatingViewDemo
//
//  Created by Hishara Dilshan on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RatingView(titleText: "How is our app experience?") { (rating: CGFloat, feedback: String) in
            
        }
    }
}

#Preview {
    ContentView()
}
