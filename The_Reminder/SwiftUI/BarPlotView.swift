//
//  BarPlotView.swift
//  The_Reminder
//
//  Created by Ashok on 22/05/24.
//

import SwiftUI
import Charts
import RealmSwift

struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}
struct BarData: Identifiable{
    var id: ObjectIdentifier
    
     var value : Int = 0
     var time : String = ""
     var date : String = ""
}
var stackedBarData: [BarData] = []
/*var stackedBarData: [ToyShape] = [
    .init(color: "Green", type: "Cube", count: 2),
    .init(color: "Green", type: "Sphere", count: 0),
    .init(color: "Green", type: "Pyramid", count: 1),
    .init(color: "Purple", type: "Cube", count: 1),
    .init(color: "Purple", type: "Sphere", count: 1),
    .init(color: "Purple", type: "Pyramid", count: 1),
    .init(color: "Pink", type: "Cube", count: 1),
    .init(color: "Pink", type: "Sphere", count: 2),
    .init(color: "Pink", type: "Pyramid", count: 0),
    .init(color: "Yellow", type: "Cube", count: 1),
    .init(color: "Yellow", type: "Sphere", count: 1),
    .init(color: "Yellow", type: "Pyramid", count: 2),
    .init(color: "Yellow", type: "Square", count: 1),
    .init(color: "Yellow", type: "Triangle", count: 1),
    .init(color: "Yellow", type: "Rectangle", count: 2),
    
    .init(color: "Green", type: "manisha", count: 2),
    .init(color: "Green", type: "a", count: 0),
    .init(color: "Green", type: "b", count: 1),
    .init(color: "Purple", type: "c", count: 1),
    .init(color: "Purple", type: "d", count: 1),
    .init(color: "Purple", type: "e", count: 1),
    .init(color: "Pink", type: "f", count: 1),
    .init(color: "Pink", type: "g", count: 2),
    .init(color: "Pink", type: "h", count: 0),
    .init(color: "Yellow", type: "i", count: 1),
    .init(color: "Yellow", type: "j", count: 1),
    .init(color: "Yellow", type: "k", count: 2),
    .init(color: "Yellow", type: "l", count: 1),
    .init(color: "Yellow", type: "m", count: 1),
]*/


@available(iOS 14.0, *)
struct BarPlotView: View {
   @StateObject var vm = ViewModel()
    var body: some View {
        VStack{
            if #available(iOS 16.0, *) {
                if #available(iOS 17.0, *) {
                    Chart {
                        ForEach(stackedBarData) { shape in
                            BarMark(
                                x: .value("Shape Type", shape.type),
                                y: .value("Total Count", shape.count)
                            )
                        }
                    }.foregroundColor(.cyan)
                    .chartScrollableAxes(.horizontal)
                    .chartXVisibleDomain(length: 10)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .onReceive(vm.$wdatasChart, perform: { _ in
            updateStackedBarData()
        })
        .onAppear{
            updateStackedBarData()
        }
    }
    private func updateStackedBarData() {
        // Convert wdatas to stackedBarData format
        var newData: [BarData] = []
        for data in vm.wdatasChart{
            newData.append(BarData(id: UUID(), value: data.value,time: data.time,date: data.date))
        }
        stackedBarData = newData
    }
}

#Preview {
    if #available(iOS 14.0, *) {
        BarPlotView()
    } else {
        // Fallback on earlier versions
    }
}
