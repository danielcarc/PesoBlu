//
//  MonedaModel.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 14/06/23.
//

import Foundation

struct MonedaModel: Decodable{
    let rates: Rates

    enum CodingKeys: String, CodingKey{
        case rates = "rates"
    }
//
}
struct Rates: Decodable{
    let BRL: Brl
    let CLP: Clp
    let UYU: Uyu
    
    enum CodingKeys: String, CodingKey{
        case BRL = "BRL"
        case CLP = "CLP"
        case UYU = "UYU"
    }
}

struct Brl: Decodable{
    let rate: String?
    enum CodingKeys: String, CodingKey{
        case rate = "rate"
    }
}
struct Clp: Decodable{
    let rate: String?
    enum CodingKeys: String, CodingKey{
        case rate = "rate"
    }
}
struct Uyu: Decodable{
    let rate: String?
    enum CodingKeys: String, CodingKey{
        case rate = "rate"
    }
}
