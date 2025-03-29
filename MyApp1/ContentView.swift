//
//  ContentView.swift
//  MyApp1
//
//  Created by Okamoto Koichiro on 2025/03/29.
//

import SwiftUI

struct StarRatingView: View {
    @State private var rating: Int = 0
    let maxRating: Int = 5
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .font(.title)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Rate your experience")
                .font(.headline)
                .padding(.bottom)
            
            StarRatingView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
