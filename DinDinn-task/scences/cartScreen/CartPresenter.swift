//
//  CartPresenter.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import Foundation
import RxSwift
import RxCocoa
protocol CartScreenProtocal {
    func loadItems()
    func removeItem(item : OrderEntity)
    var items : PublishSubject <[OrderEntity]>{ get  }
    var totalValue : PublishSubject <String>{ get  }
    

    
}
class CartPresenter: NSObject , CartScreenProtocal
{
    
    var items: PublishSubject<[OrderEntity]>
    
    var totalValue: PublishSubject<String>
    
    override init() {
        
        items = PublishSubject<[OrderEntity]>()
        totalValue =  PublishSubject<String>()
    }
  
    func loadItems() {
        let item =  CartItems.shared.getAllItems()
        items.onNext( item)
        var totalPrice = 0
        for item in item{
            totalPrice = totalPrice + (item.price ??  0)
        }
        totalValue.onNext("\(totalPrice)")
        
    }
    
    func removeItem(item: OrderEntity) {
        CartItems.shared.deleteItem(item: item)
        loadItems()
    }
    
   
    
}
