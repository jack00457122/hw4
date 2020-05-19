//
//  Start.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct Start: View {

    @ObservedObject var deathData = DeathData()
    @State var testStart = false
    @State var showMeanButton = false
    @State var showappearance = false
    @State var showIsAlive = false
    @State var showNextButton = false
    @State var showStartButton = true
    @State var indexDeath = 0
    @State var showStartAlert = false
    
    var body: some View {
        ZStack{
            
            if showStartButton{
                Button("制裁開始"){
                    if self.deathData.death.count == 0 {
                        self.showStartAlert = true
                    }
                    else{
                    self.testStart = true
                     self.showMeanButton = true
                    self.showStartButton = false
                    }
                }.font(.system(size: 40))
                    .padding(5)
                .background(Color.white)
                .foregroundColor(.red)
                    .cornerRadius(10.0)
                .position(x: 200, y: 350)
                .alert(isPresented: $showStartAlert)
                       {
                           () -> Alert in
                           return Alert(title: Text("沒有目標"), message: Text("必須取得名字"))
                }
                
            }
            
            else{
                if testStart{
                    VStack{
                    Text("對以下的目標進行制裁")
                    .font(.system(size: 50))
                    .padding()
                    .position(x: 200, y: 200)
                        .foregroundColor(.red)
                    Text(deathData.death[indexDeath].EngName)
                    .font(.system(size: 50))
                    .padding()
                    .position(x: 200, y: 200)
                    }
                    if  showMeanButton{
                        Button("制裁執行"){
                           self.showappearance = true
                           self.showIsAlive = true
                            self.showMeanButton = false
                        }.padding(5).background(Color.yellow)
                            .font(.system(size: 24))
                        .position(x: 200, y: 650)
                    }
                    
                    if showappearance{
                        
                    Image(deathData.death[indexDeath].appearance)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding(25)
                    .position(x: 200, y: 370)
                        
                    }
                    
                    if showIsAlive{
                        Button("即死"){
                            self.deathData.death[self.indexDeath].isAlive = 1
                            self.showIsAlive = false
                            self.showNextButton = true
                            if self.indexDeath + 1 == self.deathData.death.count{
                                self.showNextButton = false
                            }
                        }.padding(5).background(Color.red)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                        .position(x: 150, y: 650)
                        Button("無盡折磨"){
                            self.deathData.death[self.indexDeath].isAlive = -1
                            self.showIsAlive = false
                            self.showNextButton = true
                            if self.indexDeath + 1 == self.deathData.death.count{
                                self.showNextButton = false
                            }
                        }.padding(5).background(Color.yellow)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                        .position(x: 250, y: 650)
                        
                        
                    }
                
                    if showNextButton
                    {
                        Button("下一位"){
                            self.indexDeath = self.indexDeath + 1
                            self.showappearance = false
                             self.showMeanButton = true
                            self.showNextButton = false
                        }.padding(5).background(Color.green)
                            .font(.system(size: 24))
                        .position(x: 200, y: 650)
                    }
                }
            }
            Button("制裁結束"){
                 self.showStartButton = true
                 self.indexDeath = 0
                 self.showIsAlive = false
                self.showNextButton = false
                self.showappearance = false
            }.position(x: 200, y: 700)
                .font(.system(size: 30))
            
        }.background(Image("筆記")
            .resizable()
        .scaledToFill()
            .opacity(0.5)
        )
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start(deathData:DeathData())
    }
}
