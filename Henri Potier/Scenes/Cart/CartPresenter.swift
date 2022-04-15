//
//  CartPresenter.swift
//  Henri Potier
//
//  Created by YEH on 15/4/2022.
//

import Foundation

protocol CartPresentationLogic {
    func presentCommercialOffers(_ offers: CommercialOffers.Response)
    func presentError(_ message: String)
}

class CartPresenter: CartPresentationLogic {
    
    weak var viewController: CartDisplayLogic!
    
    init(viewController: CartDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentCommercialOffers(_ offers: CommercialOffers.Response) {
        let totalPrice = Session.cart.reduce(0) { $0 + $1.price }
        var reducedPrice = totalPrice
        var bestOffer: CommercialOffers.Offer!
        
        offers.offers.forEach {
            switch $0.type {
            case .percentage:
                let newPrice = totalPrice - ((totalPrice * $0.value) / 100)
                if newPrice < reducedPrice {
                    reducedPrice = newPrice
                    bestOffer = $0
                }
                break
            case .minus:
                let newPrice = totalPrice - $0.value
                if newPrice < reducedPrice {
                    reducedPrice = newPrice
                    bestOffer = $0
                }
                break
            case .slice:
                guard let sliceValue = $0.sliceValue else { return }
                let reductionAmount = Int(totalPrice / sliceValue) * $0.value
                let newPrice = totalPrice - reductionAmount
                if newPrice < reducedPrice {
                    reducedPrice = newPrice
                    bestOffer = $0
                }
                break
            }
            
        }
        
        let vm = CommercialOffers.ViewModel(totalPrice: totalPrice, bestOffer: bestOffer, newPrice: reducedPrice)
        viewController.displayBestCommercialOffers(viewModel: vm)
    }
    
    func presentError(_ message: String) {
        viewController.displayError(message)
    }
}
