//
//  ImagesLoader.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import Foundation
import UIKit

extension UIImageView{
    
    func featchImage( urlString : String,imageName : String){
        if  let url = URL(string: urlString) {
             let task = URLSession.shared.dataTask(with: url) { data, response, error in
                 guard let data = data else { return }
                 DispatchQueue.main.async {
                    self.image = UIImage.init(data: data)
                 
             }
        }
             task.resume()
            
    }
        else {
            self.image = UIImage.init(named: imageName)
        }
    
}
}
