//
//  HomeRouter.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/19/20.
//

import Foundation
import UIKit

protocol HomeRouterProtocal {
    func openCartScreen(viewController : UIViewController)
}

class HomeRouter:HomeRouterProtocal{
    func openCartScreen(viewController: UIViewController) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "cartScreenID")
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
 
    
    
    
}
