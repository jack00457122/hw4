//
//  Deathdata.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import Foundation

class DeathData: ObservableObject{
    
    @Published var death = [Death](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(death){
                UserDefaults.standard.set(data, forKey:"death")
            }
        }
    }
    
    init(){
        if let data =
            UserDefaults.standard.data(forKey:"death"){
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Death].self, from:data){
                death = decodedData
            }
        }
    }
    
}
