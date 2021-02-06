////  Created by Victor Hernandez.
//  Copyright © 2020 Victor Hernandez. All rights reserved.
//  Contact victoralfonso920@gmail.com

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    //to store our SwiftUI View...
    var content:Content
    
    //Getting Rect To Calculate Wdth And Height Off ScrollView...
    var rect:CGRect
    
    // ConstentOffset...
    @Binding var offset:CGFloat
    
    //Tabs
    var tabs:[Any]
    
    //ScrollView...
    // For Paging AKA Scrollable Tabs...
    let scrollView = UIScrollView()
    
    init(tabs:[Any],rect:CGRect,offset: Binding<CGFloat>,@ViewBuilder content: () -> Content){
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        setUpScrollView()
        
        //setting Constent Size...
        
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
            //Update View...
        if uiView.contentOffset.x != offset{
            // Animating
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
            } completion: { (status) in
                if status{uiView.delegate = context.coordinator}
            }
        }
    }
    
    func setUpScrollView(){
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    //Extracting SwiftUI View...
    func extractView() -> UIView{
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        return controller.view!
    }
    
    // Delegate Function To get Offset..
    class Coordinator: NSObject,UIScrollViewDelegate{
        
        var parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar){
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView){
            parent.offset = scrollView.contentOffset.x
        }
    }
  
}

struct ScrollableTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
