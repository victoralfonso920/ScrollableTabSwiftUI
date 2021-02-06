////  Created by Victor Hernandez.
//  Copyright © 2020 Victor Hernandez. All rights reserved.
//  Contact victoralfonso920@gmail.com

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0
    @State var showCapsule = false
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            let rect = proxy.frame(in: .global)
            ScrollableTabBar(tabs: tabs, rect: rect, offset: $offset){
                HStack(spacing: 0){
                    ForEach(image_URLs.indices,id:\.self){ index in
                        
                        WebImage(url: URL(string: image_URLs[index]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width)
                            //Again bug so use corner radius....
                            .cornerRadius(0)
                            .overlay(Color.black.opacity(0.3))
                    }
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .overlay(
            TabBar(offset: $offset,showCapsule: $showCapsule),
            alignment: .top
        )
        .overlay(
            
            //Enlarge capsule button
            Button(action: {
                    withAnimation{showCapsule.toggle()
                    }
            }, label: {
                Image(systemName: "fiberchannel")
                    .font(.title2)
                    .padding()
                    .background(Color.green.opacity(0.9))
                    .foregroundColor(.black)
                    .clipShape(Circle())
            })
            .padding()
            ,alignment: .bottomTrailing
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let tabs = ["Home","Search","Account"]
