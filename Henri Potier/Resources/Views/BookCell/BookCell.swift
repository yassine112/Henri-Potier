//
//  BookCell.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import UIKit
import Kingfisher

class BookCell: UITableViewCell {
    
    static let nib = UINib(nibName: "BookCell", bundle: nil)
    static let identifier = "BookCellIdentifier"
    
    // MARK: Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var addToCartAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addToCartBtn.layer.cornerRadius = 5.0
        coverImg.layer.cornerRadius = 5.0
        containerView.layer.cornerRadius = 5.0
    }
    
    func fill(_ book: Book.ResponseItem, _ addToCart: @escaping () -> Void) {
        titleLbl.text = book.title
        priceLbl.text = "\(book.price) $"
        coverImg.kf.setImage(with: URL(string: book.cover))
        
        addToCartAction = addToCart
    }
    
    @IBAction func didTapAddToCart(_ sender: UIButton) {
        addToCartAction?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
