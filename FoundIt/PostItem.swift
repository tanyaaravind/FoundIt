//
//  PostItem.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI

struct PostItem: View {
    var name: String
    var netID: String
    var description: String
    var image: Image
    
    var body: some View {
        VStack{
            HStack{
                Text(name)
                Text(netID)
            }
            
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
        }
        .frame(width: 350, height: 100)
        .background(Color(.systemGray5))
        .cornerRadius(15.0)
        .padding(50)
        
    }
    
    
}


#Preview {
    PostItem(name: "Tanya", netID: "ta374", description: "yellow beanie", image: Image("yellowhat"))
}
