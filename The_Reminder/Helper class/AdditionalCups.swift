//
//  AdditionalCups.swift
//  The_Reminder
//
//  Created by Ashok on 22/01/24.
//

import Foundation

class AdditionalCups{
    var additionalCups = [
        [
            "image":"100",
            "quantity":"100 ml",
            "isDeletable" : false
        ],
        [
            "image":"125",
            "quantity":"125 ml",
            "isDeletable" : false
        ],
        [
            "image":"150",
            "quantity":"150 ml",
            "isDeletable" : false
        ],
        [
            "image":"175",
            "quantity":"175 ml",
            "isDeletable" : false
        ],
        [
            "image":"200",
            "quantity":"200 ml",
            "isDeletable" : false
        ],
        [
            "image":"300",
            "quantity":"300 ml",
            "isDeletable" : false
        ],
        [
            "image":"400",
            "quantity":"400 ml",
            "isDeletable" : false
        ],
        [
            "image":"customize",
            "quantity":"Customize",
            "isDeletable" : false
        ],
        
    ]
    var drinkingTips = [
        "Do not drink water immediately after eating.",
        "Do not drink cold immediately after hot drinks like tea or coffee.",
        "Do not drink cold water or water with ice.",
        "Hold the water in your mouth for a while before swallowing.",
        "Always drink water while you are sitting.",
//        "The best time to drink water are, when you wake up in the morning and an hour before and after meals and also before going to bed.",
        "Drink your glass of water slowly with some small sips.",
    ]
    func getTips()->String{
        let index = Int.random(in: 0..<6)
        return drinkingTips[index]
    }
    
    func get()-> NSArray{
        return additionalCups as NSArray
    }
    func add(quantity:Int , imageName:String = "100"){
        if additionalCups.count > 0{
            let cup : [String : Any] = [
                "image": imageName,
                "quantity": "\(quantity)",
                "isDeletable" : true
            ]
            additionalCups.insert(cup, at: additionalCups.count - 1)
        }
    }
    func delete(index:Int){
        if additionalCups.count > index{
            additionalCups.remove(at: index)
        }
    }
}
