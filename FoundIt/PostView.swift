//
//  PostView.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    @State private var newPost: String = ""
    @State private var showingPhotoOption: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @State private var showingPhotoGallery: Bool = false
    @State private var image = UIImage(named: "yellowhat")
    @State private var showingCamera: Bool = false
    
    // For backend
    func toBase64 (image: UIImage) -> String {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    print("Post")
                } label: {
                    Text("Post")
                }
                
            }
            .padding(.horizontal)
            
            HStack (spacing: 8) {
                Button {
                    showingPhotoOption.toggle()
                } label: {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .confirmationDialog("Select a method", isPresented: $showingPhotoOption, titleVisibility: .visible) {
                    Button("New Photo") {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            showingCamera.toggle()
                        }
                    }
                    Button("Existing Photo") {
                        showingPhotoGallery.toggle()
                    }
                }
                .photosPicker(isPresented: $showingPhotoGallery, selection: $photoItem)
                TextField("Report a Lost or Found Object", text: $newPost, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showingCamera) {
            CameraView() { image in
                self.image = image
                showingCamera = false
                photoItem = nil
            }
        }
        .onChange(of: photoItem, initial: true) { _ , image in
            Task {
                showingPhotoGallery = false
                if let data = try? await image?.loadTransferable(type: Data.self) {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
    
}


#Preview {
    PostView()
}
