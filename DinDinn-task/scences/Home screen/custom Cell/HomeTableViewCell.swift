//
//  HomeTableViewCell.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/19/20.
//

import UIKit
import RxCocoa
import RxSwift
class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var addtoCart: UIButton!
    
    @IBOutlet weak var itemImage: UIImageView!
    private let disposeBag = DisposeBag()
    var addedOrder : PublishSubject<OrderEntity> = PublishSubject<OrderEntity>()
    var subscription: Disposable?

    var model : OrderEntity?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configurebinding()
    }
    func setUpData( model : OrderEntity?){
        if let model = model{
            self.model = model
            nameLabel.text = model.name
            sizeLabel.text = model.size ?? "" + " , " + (model.weight ??  "")
            descriptionLable.text = model.desc
            addtoCart.setTitle("\(model.price ?? 0) usd", for: .normal)
            itemImage.featchImage(urlString: model.imageUrl ?? "", imageName: "pizza")
        }
    }
    func configurebinding(){
      subscription =   addtoCart.rx.tap.subscribe(onNext: { [weak self] in
            
            self?.addedOrder.onNext((self?.model!)!)
            self?.addtoCart.setTitle("added + 1", for: .normal)
            self?.addtoCart.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // Put your code which should be executed with a delay here
                self?.addtoCart.setTitle("55 usd", for: .normal)
                self?.addtoCart.backgroundColor = .black
            }
            
         
            
        } )
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
