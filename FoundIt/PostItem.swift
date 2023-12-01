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
            
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200, alignment: .leading)
                .clipped()
            
            Spacer()
            
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Text(name)
                        Text(netID)
                    }
                    .padding(.bottom, 50)
                    Text(description)
                }
                .frame(width: 150, height: 200)
                //.background(Color.blue)
                .padding(.trailing, 50)
                
        }
        .frame(width: 350, height: 175)
        .background(Color(.systemGray5))
        .cornerRadius(15.0)
    }
    
    
}


#Preview {
    PostItem(name: "Tanya", netID: "ta374", description: "yellow beanie found at RPCC", image: Image("yellowhat"))
}
