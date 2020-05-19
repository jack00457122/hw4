//
//  ContentView.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var deathData = DeathData()
    var body: some View {
        
         TabView{
            DeathList(deathData: self.deathData).tabItem {
                       Image(systemName: "text.aligncenter")
                       Text("死亡名單")
            }
            AnalysisGrapic(deathData: self.deathData).tabItem {
                    Image(systemName: "rectangle.expand.vertical")
                    Text("制裁結果")
                  }
            Start(deathData: self.deathData).tabItem {
               Image(systemName: "circle.grid.hex.fill")
               Text("執行")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
