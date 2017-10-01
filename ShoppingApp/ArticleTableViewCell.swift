//
//  ArticleTableViewCell.swift
//  ShoppingApp

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    

    override func prepareForReuse() {
            super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(data:Article) {
        articleTitleLabel.text = data.name
        priceLabel.text = data.price
        articleImageView.image = UIImage(data:data.images[0].articleImageData)
    }
}
