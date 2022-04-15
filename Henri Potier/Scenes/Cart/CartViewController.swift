//
//  CartViewController.swift
//  Henri Potier
//
//  Created by YEH on 15/4/2022.
//

import UIKit

protocol CartDisplayLogic: AnyObject {
    func displayBestCommercialOffers(viewModel: CommercialOffers.ViewModel)
    func displayError(_ message: String)
}

class CartViewController: UIViewController, CartDisplayLogic {
    var interactor  : CartBusinessLogic?
    
    @IBOutlet weak var tableView    : UITableView!
    @IBOutlet weak var oldPriceLbl  : UILabel!
    @IBOutlet weak var reductionLbl : UILabel!
    @IBOutlet weak var newPriceLbl  : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        getCommercialOffers()
    }
    
    // MARK: Private Methods
    private func setupView() {
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
    }
    
    private func getCommercialOffers() {
        guard Session.cart.count > 0 else { return }
        interactor?.getCommercialOffers(Session.cart)
    }
    
    // MARK: Display Logic
    func displayBestCommercialOffers(viewModel: CommercialOffers.ViewModel) {
        // TODO: Remake UI
        oldPriceLbl.text = "\(viewModel.totalPrice)"
        reductionLbl.text = "\(viewModel.bestOffer.type) \(viewModel.bestOffer.value)"
        newPriceLbl.text = "\(viewModel.newPrice)"
    }
    
    func displayError(_ message: String) {
        showError(message)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Session.cart.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell {
            cell.addToCartBtn.setTitle("Remove item", for: .normal)
            cell.fill(Session.cart[indexPath.row]) { [weak self] in
                Session.cart.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                self?.getCommercialOffers()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    
}
