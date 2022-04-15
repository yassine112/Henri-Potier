//
//  CartInteractor.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 15/4/2022.
//

import Foundation
import Moya

protocol CartBusinessLogic {
    func getCommercialOffers(_ books: Book.Response)
}

class CartInteractor: CartBusinessLogic {
    
    let presenter   : CartPresentationLogic!
    let provider    = MoyaProvider<BibloServices>()
    
    init(presenter: CartPresentationLogic) {
        self.presenter = presenter
    }
    
    func getCommercialOffers(_ books: Book.Response) {
        // Create path parameter
        let isbnStr = books.map { $0.isbn }.joined(separator: ",")
        
        provider.request(.commercialOffers(isbn: isbnStr)) { [weak self] result in
            guard let self = self else { return } // prevent memory lack (retain cycle)
            switch result {
                case .success(let response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let offers = try JSONDecoder().decode(CommercialOffers.Response.self, from: filteredResponse.data)
                        self.presenter.presentCommercialOffers(offers)
                    } catch {
                        // status Code != 200~299
                        // Use of generique message insted of error.localizedDescription
                        // error.localizedDescription is not clear to the final user
                        self.presenter.presentError("Technical problem occurred")
                    }
                case .failure(let err):
                    self.presenter.presentError(err.localizedDescription)
            }
        }
    }
    
}
