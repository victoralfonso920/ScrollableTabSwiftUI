////  Created by Victor Hernandez.
//  Copyright © 2020 Victor Hernandez. All rights reserved.
//  Contact victoralfonso920@gmail.com

import SwiftUI

struct TabBar: View {
    
    @Binding var offset:CGFloat
    @Binding var showCapsule: Bool
    @State var width : CGFloat = 0
    
    var body: some View {
        
        GeometryReader{ proxy -> AnyView in
            
            //Equals Width..
            let equalsWidth = proxy.frame(in: .global).width / CGFloat(tabs.count)
            
            DispatchQueue.main.async {
                self.width = equalsWidth
            }
            
            return AnyView(
            
                ZStack(alignment: .bottomLeading, content: {
                    
                    Capsule()
                        .fill(Color.green.opacity(0.7))
                        .frame(width: equalsWidth - 15, height: showCapsule ? 40 : 4)
                        .offset(x: getOffset() + 7)
                    
                    
                    HStack(spacing: 0){
                        ForEach(tabs.indices, id: \.self){ index in
                            Text(tabs[index])
                                .fontWeight(.bold)
                                .foregroundColor(showCapsule ? (getIndezFromOffset() == CGFloat(index) ? .black : .white) : .white )
                                .frame(width: equalsWidth, height: 40)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    //Setting Offset....
                                    offset = UIScreen.main.bounds.width * CGFloat(index)
                                }
                        }
                    }
                })
                .frame(maxWidth: .infinity, maxHeight:40 ,alignment: .center)
                .clipShape(Capsule())
               
            )
        }
        .padding()
        .frame(height:40)
    }
    
    func getOffset() -> CGFloat{
        let progress = offset / UIScreen.main.bounds.width
        return progress * width
    }
    
    func getIndezFromOffset() -> CGFloat{
        let indexFloat = offset / UIScreen.main.bounds.width
        return indexFloat.rounded(.toNearestOrAwayFromZero)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
