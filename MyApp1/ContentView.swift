//
//  ContentView.swift
//  MyApp1
//
//  Created by Okamoto Koichiro on 2025/03/29.
//

import SwiftUI
import PhotosUI

struct StarRatingView: View {
    @Binding var rating: Int
    let maxRating: Int = 5
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? themeManager.currentTheme.starFilled : themeManager.currentTheme.starEmpty)
                    .font(.title)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}

struct ReviewFormView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var rating: Int = 0
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var isShowingCamera = false
    @State private var imageSelection: PhotosPickerItem?
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Your Information")) {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.headline)
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.vertical, 4)
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                        TextEditor(text: $description)
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(themeManager.currentTheme.formBorder, lineWidth: 1)
                            )
                    }
                    .padding(.vertical, 4)
                }
                
                Section(header: Text("Rating")) {
                    VStack(alignment: .center) {
                        Text("How would you rate your experience?")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        StarRatingView(rating: $rating)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical, 4)
                }
                
                Section(header: Text("Add Photo")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Add an image to your review")
                            .font(.headline)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .cornerRadius(8)
                        }
                        
                        HStack {
                            Button {
                                isShowingImagePicker = true
                            } label: {
                                Label("Photo Library", systemImage: "photo")
                            }
                            
                            Button {
                                isShowingCamera = true
                            } label: {
                                Label("Camera", systemImage: "camera")
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section {
                    Button {
                        // Submit form logic would go here
                        print("Review submitted: \(name), \(description), Rating: \(rating)")
                    } label: {
                        Text("Submit Review")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(themeManager.currentTheme.buttonBackground)
                    .cornerRadius(8)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Write a Review")
            .sheet(isPresented: $isShowingImagePicker) {
                PhotosPicker("Select a photo", selection: $imageSelection, matching: .images)
            }
            .sheet(isPresented: $isShowingCamera) {
                // In a real app, you would implement camera functionality here
                Text("Camera would open here")
                    .padding()
            }
            .onChange(of: imageSelection) { 
                loadTransferable(from: imageSelection)
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem?) {
        Task {
            if let data = try? await imageSelection?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
            }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        ReviewFormView()
    }
}

#Preview {
    let themeManager = ThemeManager(colorScheme: .light)
    return ContentView()
        .environmentObject(themeManager)
}
