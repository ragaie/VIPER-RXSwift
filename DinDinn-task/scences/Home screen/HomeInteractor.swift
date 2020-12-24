//
//  HomeInteractor.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/19/20.
//

import Foundation
//https://dindin.getsandbox.com/home
import Moya
import Moya_ObjectMapper
import RxSwift
import RxCocoa

protocol HomePresenterProtocal {
    
    
    func retriveHomeData()
    

    var item : PublishSubject <HomeEntity>{ get  }
    var loadingSubject : BehaviorRelay <Bool>{get}
    var errorMessage: PublishSubject<String>{get}

    
}

class HomeInteractor: NSObject,HomePresenterProtocal {
  
    
    var item: PublishSubject<HomeEntity>
    var errorMessage: PublishSubject<String>

    var loadingSubject: BehaviorRelay<Bool>
    
    
    let networking: MoyaProvider<DinDinn>
    
    init(networking: MoyaProvider<DinDinn>) {
      self.networking = networking
        item = PublishSubject <HomeEntity>()
        loadingSubject = BehaviorRelay<Bool>(value: true)
        errorMessage = PublishSubject<String>()
    }
    
    
    func retriveHomeData() {
      networking.request(.home, completion: { [weak self] result  in
        self?.loadingSubject.accept(false)
        switch result {
        case let .success(response):
          do {
            let homeData: HomeEntity? = try response.mapObject(HomeEntity.self)
            if let object = homeData {
                self?.item.onNext(object)
            } else {
                self?.errorMessage.onNext("data is empty")
            }
          } catch {
            self?.errorMessage.onNext("failed parse object")

          }
        case let .failure(error):
          guard let description = error.errorDescription else {
            break
          }
            self?.errorMessage.onNext(description)
        }
              })
    }
    
}
