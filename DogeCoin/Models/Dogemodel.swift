//
//  Dogemodel.swift
//  DogeCoin
//
//  Created by Apple on 28/01/2023.
//

import Foundation

struct APIResponse: Codable {
    let data:[Int: DogeCoinModel]
    
}

struct DogeCoinModel: Codable {
    let id:Int
    let name:String
    let symbol:String
    let date_added: String
   let tags: [String]
    let total_supply:Float
   let quote:[String: Quote]
    
}
struct Quote:Codable{

    let price:Float
    let volume_24h:Float
}
