//
//  ViewModel.swift
//  The_Reminder
//
//  Created by Ashok on 20/01/24.
//

import Foundation
import RealmSwift

class ViewModel : NSObject{
    let realm = try! Realm()
    var wdatas : Results<WDatas>!
    func addValue(){
        self.wdatas = self.realm.objects(WDatas.self)
        print("fff",wdatas.count)
        
        let result = getDateAndTime()
        print(result)
        let inputDate = result[0]
        let inputTime = result[1]
        let addInstance = WDatas()
        let quantity = UserDefaults.standard.integer(forKey: "selectedCup")
        addInstance.value = quantity
        addInstance.date = inputDate
        addInstance.time = inputTime
        
        try! self.realm.write{
            self.realm.add(addInstance)
        }
    }
    func getValue(completion : @escaping(_ datas :Results<WDatas>?)->Void){
        let result = getDateAndTime()
        let inputDate = result[0]
        print(result)
        self.wdatas = self.realm.objects(WDatas.self).filter("date == %@", inputDate).sorted(byKeyPath: "time", ascending: false)
        print("fff",wdatas.count)
        completion(wdatas)
    }
    func getDateAndTime()->[String]{
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        let result = dateFormatter.string(from: date).components(separatedBy: ",")
        print(result)
        return result
    }
}
