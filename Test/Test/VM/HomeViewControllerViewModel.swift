//
//  HomeViewControllerViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class HomeViewControllerViewModel: BaseCategoryViewModelProtocol {

    var categoriesDataSource: [CellViewModelProtocol] = []
    
    var categoriesListDataSource: [CellViewModelProtocol] = []
    
    private var bag = DisposeBag()
    
    func requestNesData(complete: @escaping ((Error?) -> Void)) {
        requestCategories().subscribe(onNext: { [weak self] (categories) in
//            print("请求成功======:%@",categories);
            let recommendCategory = Category(id:0, name:"推荐")
            var categoryArr = [recommendCategory]
            categoryArr.append(contentsOf: categories)
            
            self?.categoriesDataSource = categoryArr.map {
                return CategoryCollectionViewCellViewModel(category: $0)
            }
            
            self?.categoriesListDataSource = categoryArr.map{
                return HomeCollectionViewListCellViewModel(category: $0)
            }
            
        }, onError: { (error) in
            DispatchQueue.main.async {
                
                complete(error)
            }
            print("请求失败=====");
        }, onCompleted: {
            DispatchQueue.main.async {
                complete(nil)
            }
        }).disposed(by: bag)
        
    }
    
    func requestCategories() -> Observable<[Category]> {
        
       
//        msdApiProvider.request(.categoriesListApi, callbackQueue: nil, progress: { (response) in
//            print("response = \(response)")
//        }) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//
//                    let decoder = JSONDecoder()
//
//                    let user = try decoder.decode([Category].self, from: response.data)
//                    print("user==22===\(user)")
//
//                } catch {
//                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(response))")
//                }
//            default:
//                break
//            }
//        }
        
        return msdApiProvider.rx.request(.categoriesListApi).map([Category].self,
                atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false).asObservable()
    }
}
