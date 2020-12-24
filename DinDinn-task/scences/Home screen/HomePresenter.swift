//
//  HomePresenter.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/19/20.
//

import Foundation
import RxSwift
import RxCocoa
protocol HomeScreenProtocal {
    
    
    func retriveData()
    
    func openCartScreen(viewController: UIViewController)
    func addNewOrderToCart(order : OrderEntity)
    var items : PublishSubject <[OrderEntity]>{ get  }
    var types : PublishSubject <[String]>{ get  }
    var banners : PublishSubject <[String]>{ get  }

    var errorMessage: PublishSubject<String>{get}

    var loadingSubject : BehaviorRelay <Bool>{get}
    var ordersCount : BehaviorRelay <Int>{get}
    func updateCartNumber() 

   func  filterData(index : Int)
}
class HomePresenter :NSObject,HomeScreenProtocal{
    var ordersCount: BehaviorRelay<Int>
    
   
    
    var banners: PublishSubject<[String]>
    var errorMessage: PublishSubject<String>
    var types: PublishSubject<[String]>
    private  var myInteractor : HomePresenterProtocal
    private var homeRouter : HomeRouterProtocal
    var items: PublishSubject<[OrderEntity]>
    
    
    var allItems : [OrderEntity] = []
    var allTypes : [String] = []
    
    
    var loadingSubject: BehaviorRelay<Bool>
    private let disposeBag = DisposeBag()

    override init() {
        myInteractor = HomeInteractor(networking: DinDinnProvider)
        items = PublishSubject <[OrderEntity]>()
        loadingSubject = BehaviorRelay <Bool>(value: true)
        types =  PublishSubject<[String]>()
        errorMessage =  PublishSubject<String>()
        banners = PublishSubject<[String]>()
        ordersCount =  BehaviorRelay<Int> (value: 0)

        homeRouter = HomeRouter()

    }
    
    
    func openCartScreen(viewController: UIViewController) {
        homeRouter.openCartScreen(viewController: viewController)
    }
    
    func retriveData() {
        configurebinding()
        myInteractor.retriveHomeData()
    }
    func configurebinding(){
        myInteractor.loadingSubject.bind(to: self.loadingSubject).disposed(by: disposeBag)
        myInteractor.item.subscribe { event in
            self.allItems = event.element?.items ?? []
            self.allTypes = event.element?.types ?? []
            self.items.onNext(event.element?.items?.filter{ $0.type == self.allTypes[0]} ?? [])
            self.types.onNext(event.element?.types ?? [])
            self.banners.onNext(event.element?.banners ?? [])
        }.disposed(by: disposeBag)
    }
    
    func filterData(index : Int){
        self.items.onNext(allItems.filter{ $0.type == self.allTypes[index]} )

    }
    
    func addNewOrderToCart(order: OrderEntity) {
        CartItems.shared.addNewOrder(item: order)
        //save order and post count to view again
        ordersCount.accept(CartItems.shared.itemCount())
    }
    func updateCartNumber() {
        ordersCount.accept(CartItems.shared.itemCount())

    }

}
