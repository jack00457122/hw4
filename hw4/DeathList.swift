//
//  DeathList.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct DeathList: View {
    
    @ObservedObject var deathData = DeathData()
    @State private var showEditDeath = false
    var body: some View {
        print("寫下制裁對象的名字")
        return NavigationView{
           
            List{
                ForEach(deathData.death){ (death) in
                    NavigationLink(destination: DeathEditor(deathData:
                        self.deathData, editDeath: death)){
                        DeathRow(death: death)
                    }
                }
                .onMove { (indexSet, index) in
                        self.deathData.death.move(fromOffsets: indexSet,
                                        toOffset: index)
                    }
                .onDelete{(IndexSet) in
                    self.deathData.death.remove(atOffsets: IndexSet)
                    
                }
            
            }
            .navigationBarTitle("死亡筆記本")
            .navigationBarItems(leading: EditButton(), trailing: Button(action:{
                
                self.showEditDeath = true
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                
            })).sheet(isPresented: $showEditDeath){
                NavigationView{
                    DeathEditor(deathData:self.deathData)
                }
            }
        }

    }
}

struct DeathList_Previews: PreviewProvider {
    static var previews: some View {
        DeathList(deathData: DeathData())
    }
}
