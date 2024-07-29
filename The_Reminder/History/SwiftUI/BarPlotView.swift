//
//  BarPlotView.swift
//  The_Reminder
//
//  Created by Bharath on 27/06/24.
//

import SwiftUI
import Charts

enum PickerOption: Int, CaseIterable, Equatable {
    case month = 0
    case year = 1
    
    var description: String {
        switch self {
        case .month:
            return "Month"
        case .year:
            return "Year"
        }
    }
}

struct BarPlotView: View {
    @State private var isOn = false
    @State private var selectedOption: PickerOption = .month
    @StateObject private var viewModel = graphViewModel()
    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                Text("Consumption chart")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.cyan)
            } else {
                // Fallback on earlier versions
            }
        
            
            if #available(iOS 16.0, *) {
                if #available(iOS 17.0, *) {
                    Chart{
                        ForEach(viewModel.sumByDay){ data in
                            BarMark(x: .value("suma", data.day),y: .value("summa", data.value))
                        }
                    }
                    .chartYScale(domain: [0, 100])
                    .foregroundStyle(.cyan)
                    .chartXVisibleDomain(length: 10)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                // Fallback on earlier versions
            }
            
            Spacer()
            
            Picker("Select Option", selection: $selectedOption) {
                ForEach(PickerOption.allCases, id: \.self) { option in
                    Text(option.description).tag(option)
                }
            }.pickerStyle(.segmented)
            .frame(width: 150)
            .padding()
            .onChange(of: selectedOption) { newValue in
                switch newValue {
                case .month:
                    viewModel.groupMonthData()
                case .year:
                    viewModel.groupYearData()
                }
            }
            
            
            
        }
        .onAppear{
                switch selectedOption {
                case .month:
                    viewModel.groupMonthData()
                case .year:
                    viewModel.groupMonthData()
                }
        }
        
        
        
    }
}

#Preview {
    BarPlotView()
}
