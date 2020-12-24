//
//  CartView.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import UIKit
import RxSwift
import RxCocoa
//cartScreenID
//cartCellID
class CartView: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topTabBar: TopTabBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var deleiveryFees: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    private let disposeBag = DisposeBag()
    var items = Observable.from(["dd","dd","ddd"])
    var cartPresenter : CartScreenProtocal = CartPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurebinding()
        cartPresenter.loadItems()
        // Do any additional setup after loading the view.
    }
    

    func setupUI(){

        topTabBar.buttonTitle = ["Cart","Orders","Information","Account"]
       // barItems.buttonNumber = 7
        topTabBar.delegate = self
        topTabBar.font = UIFont.boldSystemFont(ofSize: 20)
        topTabBar.selectedFont = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func configurebinding(){

//        openCartButton.rx.tap.bind { [weak self] in
//            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "cartScreenID")
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }.disposed(by: disposeBag)
//
//

        cartPresenter.totalValue.bind(to: totalPrice.rx.text).disposed(by: disposeBag)
        backButton.rx.tap.subscribe(onNext: { _ in
            self.navigationController?.popViewController(animated: true)

        } ).disposed(by: disposeBag)
        cartPresenter.items.bind(to: tableView.rx.items(cellIdentifier: "cartCellID", cellType: CartItemTableViewCell.self)){
            (index, item : OrderEntity ,cell) in
        
            cell.setUpData(model: item)
            cell.deleteItem.rx.tap.subscribe { [weak self] _ in
                
                self?.cartPresenter.removeItem(item: item)
            }.disposed(by: self.disposeBag)

        
        print(item)
      }.disposed(by: disposeBag)

    }

}


extension CartView: TopTabBarDelegate{
    func topTabBarSelected(index: Int) {
        
    }
    
    
}
