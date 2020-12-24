//
//  HomeView.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/19/20.
//

import UIKit
import RxCocoa
import RxSwift
//CollectionCellID
//tableCellID
class HomeView: UIViewController {
    
    @IBOutlet weak var barItems: TopTabBar!
    @IBOutlet weak var bannerColleectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var openCartButton: UIButton!
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var bannertopconstrain: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var tabletopConstrain: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var homePresenter : HomeScreenProtocal = HomePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurebinding()
        setupUI()
        homePresenter.retriveData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homePresenter.updateCartNumber()
    }
    
    func setupUI(){
        barItems.delegate = self
        barItems.font = UIFont.boldSystemFont(ofSize: 20)
        barItems.selectedFont = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func configurebinding(){
        
        homePresenter.banners.subscribe { items in
            self.pager.numberOfPages = items.element?.count ?? 0
        }.disposed(by: disposeBag)

        openCartButton.rx.tap.bind { [weak self] in
            self?.homePresenter.openCartScreen(viewController: self!)
        }.disposed(by: disposeBag)
        
        homePresenter.ordersCount.map{
            return "\($0)"
        }.bind(to: cartCountLabel.rx.text).disposed(by: disposeBag)
        
        contentTableView.rx.didScroll.subscribe(onNext: { [weak self] index in
            self?.SetupHomePageAnimation()
        }).disposed(by: disposeBag)
        
        homePresenter.types.subscribe { [weak self] types in
            self?.barItems.buttonTitle = types.element ?? []
            self?.barItems.buttonNumber = types.element!.count
        } .disposed(by: disposeBag)

        homePresenter.items.bind(to: contentTableView.rx.items(cellIdentifier: "tableCellID", cellType: HomeTableViewCell.self)){ [self]
            (index, item : OrderEntity ,cell) in
            cell.setUpData(model: item)
            cell.addedOrder.subscribe { (order) in
                self.homePresenter.addNewOrderToCart(order: order)
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        
        homePresenter.banners.bind(to: collection.rx.items(cellIdentifier: "cellID", cellType: BannerCollectionViewCell.self)){
            (index, item ,cell) in
            cell.setImage(url: item)
        }.disposed(by: disposeBag)
        //bind loadind value to loader
        homePresenter.loadingSubject.bind(to: self.activityLoader.rx.isAnimating).disposed(by: disposeBag)
        //
        collection.rx.setDelegate(self).disposed(by: disposeBag)
    }
 
    
    // handle home screen animation when user scroll up or down in content.
    func SetupHomePageAnimation(){
        if self.contentTableView.contentOffset.y > 100{
            UIView.animate(withDuration: 1) {
                self.cartView.alpha = 1
            }
        }
        else{
            UIView.animate(withDuration: 1) {
                self.cartView.alpha = 0
            }            }
        if self.contentTableView.contentOffset.y > 400{
            UIView.animate(withDuration: 1) {
                self.collection.alpha = 0
            }
        }
        else{
            UIView.animate(withDuration: 1) {
                self.collection.alpha = 1
            }
        }
    }
}

extension HomeView : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collection.visibleCells {
            let indexPath = collection.indexPath(for: cell)
            pager.currentPage = indexPath?.row ?? 0
        }

    }
}

extension HomeView : TopTabBarDelegate{
    func topTabBarSelected(index: Int) {
        homePresenter.filterData(index: index)
    }
}
