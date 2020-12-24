//
//  LiveCartItems.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import Foundation

class   CartItems{
    
    static var shared = CartItems()
    
    private var items : [ OrderEntity] = []
    func addNewOrder (item : OrderEntity){
        if items.filter({ $0.id == item.id}).count == 0 {
        items.append(item)
        }
    }
    func getAllItems()-> [OrderEntity]{
        return items
    }
    func deleteItem(item : OrderEntity){
        
       items =  items.filter{$0.id != item.id
            
        }
        
    }
    func itemCount()-> Int{
        return items.count
    }
}
