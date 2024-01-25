//
//  WDatas.swift
//  The_Reminder
//
//  Created by Ashok on 20/01/24.
//

import Foundation
import RealmSwift

class WDatas : Object{
    @objc dynamic var value : Int = 0
    @objc dynamic var time : String = ""
    @objc dynamic var date : String = ""
}
