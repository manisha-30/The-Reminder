//
//  WeekView.swift
//  The_Reminder
//
//  Created by Bharath on 20/07/24.
//

import SwiftUI

struct WeekView: View {
    var body: some View {
        VStack{
            Text("Weekly Completion")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
            HStack{
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("mon")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("tue")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("wed")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("thu")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("fri")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("sat")
                }.padding(10)
                VStack{
                    Image("100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("sun")
                }.padding(10)
            }
        }
        
        .background(Color.cyan)
    }
}

#Preview {
    WeekView()
}
