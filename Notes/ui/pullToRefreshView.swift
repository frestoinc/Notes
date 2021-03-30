//
//  pullToRefreshView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import UIKit
import SwiftUI

struct CustomScrollView : UIViewRepresentable {
    
    var width : CGFloat
    var height : CGFloat
    
    let data = MainViewModel()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: data)
    }
func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)
let childView = UIHostingController(rootView: MainView(viewModel: data))
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }
func updateUIView(_ uiView: UIScrollView, context: Context) {}
class Coordinator: NSObject {
        var control: CustomScrollView
        var model : MainViewModel
init(_ control: CustomScrollView, model: MainViewModel) {
            self.control = control
            self.model = model
        }
@objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            model.loadData()
        }
    }
}
