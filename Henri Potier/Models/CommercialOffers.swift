//
//  CommercialOffers.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import Foundation

enum CommercialOffers {
    
    struct Response: Codable {
        let offers: [Offer]
    }

    struct Offer: Codable {
        let type: String
        let value: Int
        let sliceValue: Int?
    }
}
