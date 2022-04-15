//
//  BooksListInteractor.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import Foundation
import Moya

protocol BooksListBusinessLogic {
    func getBooks()
}

class BooksListInteractor: BooksListBusinessLogic {
    
    let presenter   : BooksListPresentationLogic!
    let provider    = MoyaProvider<BibloServices>()
    
    init(presenter: BooksListPresentationLogic) {
        self.presenter = presenter
    }
    
    func getBooks() {
        provider.request(.getList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let filtredResponse = try response.filterSuccessfulStatusCodes()
                    let books = try? JSONDecoder().decode(Book.Response.self, from: filtredResponse.data)
                    self.presenter.presentBooksList(books)
                } catch let err {
                    // TODO: Add significant response
                    // ex: Technical problem occurred
                    self.presenter.presentError(err.localizedDescription)
                }
            case .failure(let err):
                self.presenter.presentError(err.localizedDescription)
            }
        }
    }
}
