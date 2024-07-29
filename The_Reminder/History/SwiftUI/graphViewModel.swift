//
//  graphViewModel.swift
//  The_Reminder
//
//  Created by Bharath on 28/05/24.
//
import Combine
import Foundation
import RealmSwift

struct plotData: Identifiable{
    var id = UUID()
    var day: Int
    var value: Int
}

class graphViewModel:ObservableObject{
    @Published var sumByDay: [plotData] = []
    
    func groupMonthData(){
        let realm = try! Realm()
        self.sumByDay.removeAll()
        let currentMonth = Date().currentMonth
        let data = realm.objects(WDatas.self).filter("date CONTAINS '/\(currentMonth)/'")
        var tempsumByDay: [String: Int] = [:]
        
        // Iterate through the data to sum values for each day
        for item in data {
            let components = item.date.components(separatedBy: "/")
            if components.count == 3 {
                let day = components[0] // Get the day part
                if let currentValue = tempsumByDay[day] {
                    tempsumByDay[day] = currentValue + item.value
                } else {
                    tempsumByDay[day] = item.value
                }
            }
        }
        
        var finalData: [plotData] = []
        let totalQuans = UserDefaults.standard.integer(forKey: "totalQuans")
        for day in 1...31 {
            let dayString = String(format: "%02d", day)
            if tempsumByDay[dayString] == nil {
                tempsumByDay[dayString] = 0
            }
            let value = (Double(tempsumByDay[dayString] ?? 0) / Double(totalQuans)) * 100.0
            finalData.append(plotData(day: Int(dayString) ?? 0, value: Int(value)))
        }
        self.sumByDay.append(contentsOf: finalData)
        
    }
    
    func groupYearData(){
        let realm = try! Realm()
        self.sumByDay.removeAll()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY"
        let currentYearString = dateFormatter.string(from: Date())
        if let currentYear = Int(currentYearString) {
            let data = realm.objects(WDatas.self).filter("date CONTAINS '/\(currentYear)'")
            print(data)
            
            var tempsumByDay: [String: Int] = ["01":0,
                                               "02":0,
                                               "03":0,
                                               "04":0,
                                               "05":0,
                                               "06":0,
                                               "07":0,
                                               "08":0,
                                               "09":0,
                                               "10":0,
                                               "11":0,
                                               "12":0
                        ]
            for item in data{
                let components = item.date.components(separatedBy: "/")
                if components.count == 3 {
                    let month = components[1] // Get the month part
                    tempsumByDay[month] =  (tempsumByDay[month] ?? 0) + item.value
                }
            }
            print(tempsumByDay)
            
            var finalData: [plotData] = []
            let totalQuans = UserDefaults.standard.integer(forKey: "totalQuans")
            for day in 1...12 {
                let dayString = String(format: "%02d", day)
                let value = (Double(tempsumByDay[dayString] ?? 0) / Double(totalQuans)) * 100.0
                finalData.append(plotData(day: Int(dayString) ?? 0, value: Int(value)))
            }
            self.sumByDay.append(contentsOf: finalData)
            print(sumByDay)
        }
        

        
    }
}

extension Date {
    
    var startDateOfMonth: String {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        
        let dateformatter = DateFormatter()
        guard   let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1)) else {
            fatalError("Unable to get start date from date")
        }
        dateformatter.dateFormat = "MM"
        let dateString = dateformatter.string(from: date)
        
        return dateString
    }
    
    var currentMonth: String{
        let month = Calendar.current.component(.month, from: self)
        let dateformatter = DateFormatter()
        guard   let date = Calendar.current.date(from: DateComponents(month: month, day: 1)) else {
            fatalError("Unable to get start date from date")
        }
        dateformatter.dateFormat = "MM"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
    var endDateOfMonth: String {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let dateformatter = DateFormatter()
        guard   let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1)) else {
            fatalError("Unable to get start date from date")
        }
        guard let date1 = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: date) else {
            fatalError("Unable to get end date from date")
        }
        dateformatter.dateFormat = "dd/MM/YY"
        let dateString = dateformatter.string(from: date1)
        print(dateString)
        return dateString
    }
}
