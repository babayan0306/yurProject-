//
//  ProductCell.swift
//  Lesson11.02.2023
//
//  Created by Artur on 11.02.23.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func didSelectFavorite(selectedIndex: Int)
}

class ProductCell: UITableViewCell {

    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var favoritebutton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    
    
    var selectedInndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setFavorite(_ sender: UIButton) {
        delegate?.didSelectFavorite(selectedIndex: selectedInndex)
    }
    
    func setData(_ protuct: Product, index: Int) {
        
        self.selectedInndex = index
        iconImage.image = UIImage(named: protuct.icon)
        productName.text = protuct.title
        favoritebutton.backgroundColor = .white
        favoritebutton.setImage(protuct.isFavorite ? UIImage.init(systemName: "heart.fill") : UIImage.init(systemName: "heart"), for: .normal)
        
        
    }
}
