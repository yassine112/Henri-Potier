//
//  BooksListInteractor.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 14/4/2022.
//

import Foundation
import Moya

protocol BooksListBusinessLogic {
    func getBooks()
    func filterBooks(using text: String)
}

class BooksListInteractor: BooksListBusinessLogic {
    
    let presenter   : BooksListPresentationLogic!
    let provider    = MoyaProvider<BibloServices>()
    
    init(presenter: BooksListPresentationLogic) {
        self.presenter = presenter
    }
    
    func getBooks() {
        provider.request(.getList) { [weak self] result in
            guard let self = self else { return } // prevent memory lack (retain cycle)
            switch result {
                case .success(let response):
                    do {
                        let filtredResponse = try response.filterSuccessfulStatusCodes()
                        let books = try? JSONDecoder().decode(Book.Response.self, from: filtredResponse.data)
                        self.presenter.presentBooksList(books)
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
    
    func filterBooks(using text: String) {
        presenter.presentFiltredBooksList(text)
    }
}
