//
//  PostItem.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI



struct PostItem: View, Identifiable {
    var id: Int
    var name: String
    var netID: String
    var description: String
    var imageUrl: String

    var body: some View {

        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200, alignment: .leading)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 200, alignment: .leading)
                    .clipped()
            }

            Spacer()

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Text(name)
                        .bold()
                        .lineLimit(1)
                    Text("(" + netID + ")")
                        .italic()
                        .lineLimit(1)
                    Spacer()
                }
                .frame(width: 190, height: 50)

                Text(description)
                    .lineLimit(4)
                    .frame(width: 180, height: 110, alignment: .topLeading)
                    
            }
            .frame(width: 200, height: 175, alignment: .top)

        }
        .frame(width: 350, height: 175)
        .background(Color.lightBlue)
        .cornerRadius(15.0)
    }
}
//
//#if DEBUG
//struct PostItem_Previews: PreviewProvider {
//    static var previews: some View {
//        PostItem(name: "Tanya", netID: "ta374", description: "I found a yellow hat at RPCC it was on one of the benches come claim it if its urs ", image: Image("yellowhat"))
//    }
//}
//#endif
