//
//  CartItemTableViewCell.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import UIKit
import RxCocoa
import RxSwift
class CartItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var deleteItem: UIButton!
    @IBOutlet weak var pricelabel: UILabel!
    private let disposeBag = DisposeBag()

    var model : OrderEntity?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   

    }

    func setUpData( model : OrderEntity?){
        if let model = model{
            self.model = model
            nameLabel.text = model.name
            pricelabel.text = model.size ?? "" + " , " + (model.weight ??  "")
            pricelabel.text = "\(model.price ?? 0) usd"
            itemImage.featchImage(urlString: model.imageUrl ?? "", imageName: "pizza")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
