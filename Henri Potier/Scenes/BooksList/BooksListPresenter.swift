//
//  BooksListPresenter.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 14/4/2022.
//

import Foundation


protocol BooksListPresentationLogic {
    func presentBooksList(_ books: Book.Response?)
    func presentFiltredBooksList(_ text: String)
    func presentError(_ message: String)
}

class BooksListPresenter: BooksListPresentationLogic {
    
    weak var viewController: BooksListDisplayLogic!
    var books: Book.Response = []
    var filtredBooks: Book.Response = []
    
    init(viewController: BooksListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentBooksList(_ books: Book.Response?) {
        self.books = books ?? []
        viewController.displayBooksList(self.books)
    }
    
    func presentFiltredBooksList(_ text: String) {
        // Filter books using there names
        // Filter books in presenter layer to isolate the operation from UIViewController
        // to be readable, mantainable and easy to test
        filtredBooks = text == "" ? books : books.filter { $0.title.lowercased().contains(text.lowercased()) }
        viewController.displayBooksList(filtredBooks)
    }
    
    func presentError(_ message: String) {
        viewController.displayErrorMessage(message)
    }
    
}
