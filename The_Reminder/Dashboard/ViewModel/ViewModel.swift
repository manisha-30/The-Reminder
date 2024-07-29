//
//  ViewModel.swift
//  The_Reminder
//
//  Created by Ashok on 20/01/24.
//

import Foundation
import RealmSwift

class ViewModel : NSObject,ObservableObject{
    let realm = try! Realm()

    func addValue(quantity : Int = -1){
//        self.wdatas = self.realm.objects(WDatas.self)
//        print("fff",wdatas.count)
        
        let result = getDateAndTime()
        print(result)
        let inputDate = result[0]
        let inputTime = result[1]
        let addInstance = WDatas()
        if quantity != -1{
            addInstance.value = quantity
        }
        else{
            addInstance.value = UserDefaults.standard.integer(forKey: "selectedCup")
        }
            
        
        addInstance.date = inputDate
        addInstance.time = inputTime
        
        try! self.realm.write{
            self.realm.add(addInstance)
        }
    }
    func getValue(completion : @escaping(_ datas :[tableData],_ total: Int)->Void){
        let result = getDateAndTime()
        let inputDate = result[0]
        print(result)
        let wdatas = self.realm.objects(WDatas.self).filter("date == %@", inputDate).sorted(byKeyPath: "time", ascending: false)
        
        let data = convertTimeFormat(wdatas: wdatas)
        let finalData = data.0
        let total = data.1
        completion(finalData,total)
    }
    func convertTimeFormat(wdatas:Results<WDatas>) -> ([tableData],Int){
        var formattedData : [tableData] = []
        let dateFormatter = DateFormatter()
        var total = 0
        for wdata in wdatas{
            total += wdata.value
            dateFormatter.timeStyle = .medium
            if let date = dateFormatter.date(from: wdata.time){
                dateFormatter.timeStyle = .short
                let ftime = dateFormatter.string(from: date)
                formattedData.append(tableData(value: wdata.value,time: ftime, date: wdata.date))
            }
        }
        return (formattedData,total)
    }
    func getDateAndTime()->[String]{
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .short
        let result = dateFormatter.string(from: date).components(separatedBy: ",")
        print(result)
        return result
    }
}
