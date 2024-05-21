//
//  AdditionalCups.swift
//  The_Reminder
//
//  Created by Ashok on 22/01/24.
//

import Foundation

struct cup{
    var image: String
    var quantity: String
    var isDeletable : Bool
}
class AdditionalCups{
    static var additionalCups:[cup] = [
        cup(image: "100", quantity: "100 ml", isDeletable: false),
        cup(image: "125", quantity: "125 ml", isDeletable: false),
        cup(image: "150", quantity: "150 ml", isDeletable: false),
        cup(image: "175", quantity: "175 ml", isDeletable: false),
        cup(image: "200", quantity: "200 ml", isDeletable: false),
        cup(image: "300", quantity: "300 ml", isDeletable: false),
        cup(image: "400", quantity: "400 ml", isDeletable: false),
        cup(image: "customize", quantity: "Customize", isDeletable: false)
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
    
    func get()-> [cup]{
        return AdditionalCups.additionalCups
    }
    func updateCups(index:Int,isdeletable:Bool,image:String){
        if index < AdditionalCups.additionalCups.count{
            AdditionalCups.additionalCups[index].image = image
            AdditionalCups.additionalCups[index].isDeletable = isdeletable
        }
    }
    func add(quantity:Int , imageName:String = "100"){
        if AdditionalCups.additionalCups.count > 0{
            let cup = cup(image: imageName, quantity: "\(quantity)", isDeletable: true)
            AdditionalCups.additionalCups.insert(cup, at: AdditionalCups.additionalCups.count - 1)
        }
    }
    func delete(index:Int){
        if AdditionalCups.additionalCups.count > index{
            AdditionalCups.additionalCups.remove(at: index)
        }
    }
}
