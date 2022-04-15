//
//  BooksListPresenter.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import Foundation


protocol BooksListPresentationLogic {
    func presentBooksList(_ books: Book.Response?)
    func presentError(_ message: String)
}

class BooksListPresenter: BooksListPresentationLogic {
    
    weak var viewController: BooksListDisplayLogic!
    
    init(viewController: BooksListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentBooksList(_ books: Book.Response?) {
        viewController.displayBooksList(books ?? [])
    }
    
    func presentError(_ message: String) {
        viewController.displayErrorMessage(message)
    }
    
}
