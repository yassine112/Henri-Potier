//
//  BooksListViewController.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import UIKit

protocol BooksListDisplayLogic: AnyObject {
    func displayBooksList(_ books: Book.Response)
    func displayErrorMessage(_ message: String)
}

class BooksListViewController: UIViewController, BooksListDisplayLogic {

    var interactor  : BooksListBusinessLogic?
    var books       : Book.Response = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        interactor?.getBooks()
//        print(BooksListViewController.classForCoder())
    }
    
    // MARK: Display Logic
    
    func displayBooksList(_ books: Book.Response) {
        self.books = books
        tableView.reloadData()
    }
    
    func displayErrorMessage(_ message: String) {
        // TODO: Display error message
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
    }
    
}

extension BooksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell {
            cell.fill(books[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
