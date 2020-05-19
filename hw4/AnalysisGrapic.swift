//
//  AnalysisGrapic.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct AnalysisGrapic: View {
    
    @ObservedObject var deathData = DeathData()
    @State private var selectedAnalyzeItem = "制裁結果"
    var analyzeItems = ["制裁結果", "死法總覽",]
    var isAliveAngles: [Angle]
    var typeCount: [Double] = [0,0,0]
    
     let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
    
    init(deathData: DeathData)
    {
        self.deathData = deathData
        
        var totalCount: Double = 0
        
        var isAliveCount: [Double] = [0,0,0]

        
        for data in deathData.death
        {
            totalCount += 1
            if data.isAlive ==  0
            {
                isAliveCount[0] += 1
            }
            else if data.isAlive == 1
            {
                isAliveCount[1] += 1
            }
            else if data.isAlive == -1
            {
                isAliveCount[2] += 1
            }
            
            if data.selectedType == "心臟麻痺"
            {
                typeCount[0] += 1
            }
            else if data.selectedType == "直接電死"
            {
                typeCount[1] += 1
            }
            else if data.selectedType == "亂槍射死"
            {
                typeCount[2] += 1
            }
           
        }
        var isAlivePercentages: [Double] = [0,0,0]
        isAlivePercentages[0] = isAliveCount[0] / totalCount
        isAlivePercentages[1] = isAliveCount[1] / totalCount
        isAlivePercentages[2] = isAliveCount[2] / totalCount
        isAliveAngles = [Angle]()
        var isAliveStartDegree: Double = 0
        for isAlivePercentages in isAlivePercentages
        {
            isAliveAngles.append(.degrees(isAliveStartDegree))
            isAliveStartDegree += 360 * isAlivePercentages
        }
        if isAlivePercentages[2] == 1.0
        {
            isAliveAngles[0] = .degrees(360)
        }
    
    
    }
    var body: some View {
        ZStack{
                   Color.init(color)
                   .edgesIgnoringSafeArea(.all)
         GeometryReader
               {
                   geometry in
                   ZStack
                   {
                       Image("符合")
                       .resizable()
                       .opacity(0.3)
                       .frame(width: geometry.size.width, height: geometry.size.height)
                       .edgesIgnoringSafeArea(.all)
                       VStack
                       {
                           Text("制裁執行結果")
                           .padding(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 10))
                           Picker(selection: self.$selectedAnalyzeItem, label: Text("制裁執行結果"))
                           {
                               ForEach(self.analyzeItems, id: \.self)
                               {
                                   (analyzeItem) in
                                   Text(analyzeItem)
                               }
                           }
                           .labelsHidden()
                           .pickerStyle(SegmentedPickerStyle())
                           .padding(20)
                           if self.deathData.death.count != 0
                           {
                               if self.selectedAnalyzeItem == "制裁結果"
                               {
                                isAlivePieChart(isAliveAngles: self.isAliveAngles)
                               }
                               else if self.selectedAnalyzeItem == "死法總覽"
                               {
                                   typeBarChart(typeWidths: self.typeCount)
                                
                               }
                           }
                           else
                           {
                               Text("暫無目標")
                               .font(Font.system(size:30))
                               .fontWeight(.bold)
                               .foregroundColor(Color.white)
                               .multilineTextAlignment(.center)
                               .frame(width:250, height:250)
                                .background(Color.orange)
                                .cornerRadius(150)
                                 .shadow(radius: 30)
                           }
                       }
                   }
               }
        }
    }
}

struct AnalysisGrapic_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisGrapic(deathData: DeathData())
    }
}


struct isAlivePieChart: View
{
    var isAliveAngles: [Angle]
    var body: some View
    {
        VStack
        {
            ZStack
            {
               
                PieChart(startAngle: isAliveAngles[0], endAngle: isAliveAngles[1])
                .fill(Color.gray)
                VStack{
                    Rectangle()
                    .fill(Color.gray)
                    .frame(width: 10, height: 10)
                    Text("未制裁")
                }.offset(x:0, y: 150)

                PieChart(startAngle: isAliveAngles[1], endAngle: isAliveAngles[2])
                .fill(Color.red)
                
                VStack{
                    Rectangle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    Text("已死")
                }.offset(x:-150, y: 0)
                
                PieChart(startAngle: isAliveAngles[2], endAngle: isAliveAngles[0])
                .fill(Color.purple)
                VStack{
                   Rectangle()
                   .fill(Color.purple)
                   .frame(width: 10, height: 10)
                   Text("受到折磨")
               }.offset(x:150, y: 0)
            }
            .frame(width: 200, height: 200)
            Spacer()
            .frame(height:40)
        }
    }
}

struct typeBarChart: View
{
   
    var typeWidths: [Double]
    var body: some View
    {
        HStack
        {
            VStack
                {
                    typeText()
                }
                .frame(width: 60, height: 270)
                .padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                ZStack(alignment: .leading)
                {
                    Path
                    {
                        (path) in
                        path.move(to: CGPoint(x: 0, y: 20))
                        path.addLine(to: CGPoint(x: 0, y: 270))
                        path.addLine(to: CGPoint(x: 300, y: 270))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    typeBarGroup(typeWidths: typeWidths)
                }
            }
            .frame(width: 300, height: 270)
    }
}
struct typeText: View
{
    var body: some View
    {
        Group
        {
            Text("心臟麻痺")
           .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            Text("直接電死")
            .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            Text("亂槍射死")
           .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            
        }
    }
}

struct typeBarGroup: View
{
    var typeWidths: [Double]
    var body: some View
    {
        ScrollView(.horizontal){
           VStack(alignment: .leading)
            {
                Group
                {
                        typeBar(finalWidth: typeWidths[0], r: 1, g: 0, b: 0).padding(EdgeInsets(top: 100, leading: 0.5, bottom: 0, trailing: 0))
                        typeBar(finalWidth: typeWidths[1], r: 0, g: 1, b: 0).padding(EdgeInsets(top: 40, leading: 0.5, bottom: 10, trailing: 0))
                        typeBar(finalWidth: typeWidths[2], r: 1, g: 0, b: 1).padding(EdgeInsets(top: 20, leading: 0.5, bottom: 30, trailing: 0))
                            HStack{
                                Group{
                                    ForEach(0..<50){(index) in
                                        Text("\(index)")
                                    }
                                }
                            }
                        }
                    }
         }
    }
        
    
}

struct typeBar: View
{
    var finalWidth: Double
    var r: Double
    var g: Double
    var b: Double
    @State private var width: CGFloat = 0
    var body: some View
    {
       
            Rectangle()
            .fill(Color(red: r, green: g, blue: b))
            .frame(width: width, height: 20)
            .animation(.linear(duration: 1))
            .onAppear
            {
                self.width = CGFloat(self.finalWidth)*20
            }
        
    }
}
