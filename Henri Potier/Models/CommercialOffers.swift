//
//  CommercialOffers.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 14/4/2022.
//

import Foundation

enum OfferType: String, Codable {
    case percentage
    case minus
    case slice
}

enum CommercialOffers {
    
    struct Response: Codable {
        let offers: [Offer]
    }

    struct Offer: Codable {
        let type: OfferType
        let value: Int
        let sliceValue: Int?
    }
    
    struct ViewModel {
        let totalPrice: Int
        let bestOffer: CommercialOffers.Offer
        let newPrice: Int
    }
}
