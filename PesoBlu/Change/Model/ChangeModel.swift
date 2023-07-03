//
//  ChangeData.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 07/06/23.
//

import Foundation
struct ChangeModel: Codable{
    
    let oficial: Oficial
    let blue: Blue
    let blue_euro: BlueEuro
    var last_update: String
    var actualizacion:String{
        
        if let index = last_update.firstIndex(of: "T") {
            let truncatedString = String(self.last_update[..<index])
            let timeString = String(self.last_update[index...])
            
            let timeComponents = timeString.components(separatedBy: ":")
            var primerComponente = timeComponents.first
            _ = primerComponente!.removeFirst()
            let prim = primerComponente
            //print(primerComponente!)
            let segundoComponente = timeComponents[1]
            let tercerComponente = timeComponents[2]
            let tercer = tercerComponente.split(separator: ".")
            let tres = tercer[0]
            let actualizacion = "Ultima actualizacion \(truncatedString) \(prim!):\(segundoComponente):\(tres)"
            return actualizacion
        }
       return last_update
    }
    
    
}

struct Oficial: Codable{
    let value_sell: Double
    let value_buy: Double
}
struct Blue: Codable{
    let value_sell: Double
    let value_buy: Double
}
struct BlueEuro: Codable{
    let value_sell: Double
    let value_buy: Double
}

