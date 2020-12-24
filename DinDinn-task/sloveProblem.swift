//
//  ViewController.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/18/20.
//



/*
 
 1- big o for this soluation in o(n/2) best case
 and O(n/2 ) + 1 in worest case which is odd number
 
 2- issue with using ascii code
 need more two step to convert character to ascii then convert it again to character to return result
 */

import Foundation

class sloveProblem {

     //   print(encodeString(str: "abc", with: 28))

    
    func encodeString(str : String, with n : Int){
      //  a b c d e f g h i j k l m n o p q r s t u v w x y z
        //from 0 - 25
        let alph = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        var new  = Array(str)
        var i = 0
        var j = str.count - 1
        let count = str.count % 2 == 0 ? str.count / 2  :  (str.count / 2) + 1
        while i < count{
            
            
            
            new[i] = Character(alph[(n + i) % 26])
            if i != j{
               new[j] = Character(alph[(n + j + 1) % 26])
            }
            i += 1
            j -= 1
            
        }
        
        print(String(new))
    }

}

