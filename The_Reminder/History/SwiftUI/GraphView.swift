//
//  GraphView.swift
//  The_Reminder
//
//  Created by Bharath on 27/05/24.
//

import SwiftUI
import Charts

struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}


struct GraphView: View {
    @State private var isOn = false
    @State private var ans = 0
    // @StateObject private var viewModel = graphViewModel()
    var body: some View {
        BarPlotView()
            .frame(height: 400)
            .padding()
        
        HStack{
            Image("cup")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
                .foregroundColor(.cyan)
            Text("A healthy mind and body is a  hydrated one. Come and have  a try!")
                .fontWeight(.semibold)
                .lineLimit(3)
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
        Spacer()
        
    }
}
#Preview {
    GraphView()
}
