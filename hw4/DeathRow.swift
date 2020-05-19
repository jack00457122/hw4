//
//  DeathRow.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import SwiftUI

struct DeathRow: View {
    
    var death : Death
    var body: some View {
            HStack {
                if death.selectedType == "心臟麻痺"{
                    VStack{
                       Group{
                    Image(systemName:"wonsign.circle.fill").font(.system(size: 20))
                           Text("心臟麻痺").font(.system(size: 12))
                       }
                   .padding(-2)
                       .foregroundColor(.purple)
                   }
                }
                else if death.selectedType == "直接電死"{
                    VStack{
                        Group{
                            Image(systemName:"book.fill").font(.system(size: 20))
                            Text("直接電死").font(.system(size: 12))
                        }
                    .padding(-2)
                        .foregroundColor(.orange)
                    }
                }
                else if death.selectedType == "亂槍射死"{
                    VStack{
                        Group{
                            Image(systemName:"dongsign.square.fill").font(.system(size: 20))
                            Text("亂槍射死").font(.system(size: 12))
                        }
                    .padding(-2)
                        .foregroundColor(.red)
                    }
                }
                Text(death.EngName)
                Spacer()
                if death.isAlive == 0{
                    Image(systemName:"heart.fill").foregroundColor(.gray)
                }
                else if death.isAlive == -1
                {
                    Image(systemName:"heart.fill").foregroundColor(.red)
                }
                else if death.isAlive == 1
                {
                    Image(systemName:"heart.fill").foregroundColor(.init(red: 77/255, green: 31/255, blue: 0/255))
                }
                
            }
    }
}

struct DeathRow_Previews: PreviewProvider {
    static var previews: some View {
        DeathRow(death: Death(EngName: "像極了某鄭", appearance: "像極了某鄭",selectedType:"心臟麻痺", isAlive: 0))
    }
}
