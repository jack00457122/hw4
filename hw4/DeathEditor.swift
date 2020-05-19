//
//  DeathEditor.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct DeathEditor: View {
    @Environment(\.presentationMode) var presentationMode
       var deathData: DeathData
       @State private var EngName = ""
       @State private var appearance = "像極了某鄭"
        @State private var selectedType = ""
        @State private var isAlive = 0
        @State private var showNameAlert = false
    var looks = ["像極了某習", "像極了某韓", "像極了某鄭", "像極了某司","像極了某塞","像極了某川"]
       var editDeath: Death?
       
       var body: some View {
           Form {
            VStack {
               TextField("真名", text: $EngName)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.red, lineWidth: 5))
                .padding()
            Image(appearance)
            .resizable()
            .scaledToFit()
            .frame(width: 350, height: 250)
            Picker(selection: self.$appearance, label: Text("目標的外觀")) {
                ForEach(self.looks, id: \.self) { (place) in
                    Text(place)
                }
            }
            .pickerStyle(WheelPickerStyle())
                profileType(selectedType: self.$selectedType)
                Image(selectedType)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 250)
            }
           }
           .navigationBarTitle(editDeath == nil ? "新的制裁目標" : "已制裁的目標重新執行")
               .navigationBarItems(trailing: Button("確定") {
                
                if (self.EngName == "") || (self.appearance=="") || (self.selectedType == "")
                {
                    self.showNameAlert = true
                }
                else{
                    let death = Death(EngName: self.EngName, appearance: self.appearance,selectedType: self.selectedType, isAlive: self.isAlive)
                       if let editDeath = self.editDeath {
                           let index = self.deathData.death.firstIndex {
                               $0.id == editDeath.id
                               }!
                           self.deathData.death[index] = death
                       } else {
                           self.deathData.death.insert(death, at: 0)
                       }
                       self.presentationMode.wrappedValue.dismiss()
                }
                   
           }
           .alert(isPresented: $showNameAlert)
                  {
                      () -> Alert in
                      return Alert(title: Text("無效目標!!"), message: Text("目標資料不足無法制裁"))
                  })
               .onAppear {
                   if let editDeath = self.editDeath {
                       self.EngName = editDeath.EngName
                       self.appearance = editDeath.appearance
                       self.selectedType = editDeath.selectedType
                       self.isAlive = 0
                       
                   }
           }
           
       }
}

struct DeathEditor_Previews: PreviewProvider {
    static var previews: some View {
        DeathEditor(deathData: DeathData())
    }
}


struct profileType: View
{
    @Binding var selectedType: String
    var types = ["心臟麻痺", "直接電死", "亂槍射死"]
    var body: some View
    {
        VStack{
        Picker(selection: $selectedType, label: Text("死因"))
        {
            ForEach(types, id: \.self)
            {
                (type) in
                Text(type)
                }
            }.pickerStyle(SegmentedPickerStyle())
                }
                    }
}
