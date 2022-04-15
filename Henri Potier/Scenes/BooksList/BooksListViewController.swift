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
        getBooks()
    }
    
    // MARK: Display Logic
    
    func displayBooksList(_ books: Book.Response) {
        self.books = books
        tableView.reloadData()
    }
    
    func displayErrorMessage(_ message: String) {
        showError(message)
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        navigationItem.title = "Henri Potier"
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
    }
    
    private func getBooks() {
        interactor?.getBooks()
    }
    
    // MARK: Actions
    
    @IBAction func didChangeValue(_ sender: UITextField) {
        interactor?.filterBooks(using: sender.text ?? "")
    }
    
    @IBAction func didTapCartBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            // Dependencies Injection
            let presenter = CartPresenter(viewController: cartVC)
            let interactor = CartInteractor(presenter: presenter)
            cartVC.interactor = interactor
            
            navigationController?.pushViewController(cartVC, animated: true)
        }
    }
}

extension BooksListViewController: UITextFieldDelegate {
    
}

extension BooksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell {
            cell.addToCartBtn.setTitle("Add to cart", for: .normal)
            cell.fill(books[indexPath.row]) { [weak self] in
                guard let self = self else { return }
                Session.cart.append(self.books[indexPath.row])
            }
            return cell
        }
        
        return UITableViewCell()
    }
}
