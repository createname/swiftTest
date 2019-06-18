//
//  GoodsViewControllerViewModel.swift
//  Test
//
//  Created by wzy on 2019/6/14.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class GoodsViewControllerViewModel: NSObject {

    public var dataSource: [CellViewModelProtocol] = []
    
    private var pageIndex = 1
    
    private var bag = DisposeBag()
    
    func requestNewData(complete:@escaping ((Error?)->Void)) {
        pageIndex = 1
        requestExperiencesList(pageIndex: pageIndex).subscribe(onNext: { [weak self](products) in
            if let strongSelf = self{
                let bannerVM = BannerTableViewCellViewModel(galleries: [])
                let categoryVM = HomeCategoriesTableViewCellViewModel()
                let goodsCess = products.map {
                    GoodsTableViewCellViewModel(product: $0)
                }
                strongSelf.dataSource = []
                strongSelf.dataSource.append(bannerVM)
                strongSelf.dataSource.append(categoryVM)
                strongSelf.dataSource.append(contentsOf: goodsCess)
            }
            }, onError: { (error) in
                DispatchQueue.main.async {
                    print("获取数据错误")
                    complete(error)
                }
        }, onCompleted: {
            DispatchQueue.main.async {
                complete(nil)
            }
        }, onDisposed: {}).disposed(by: bag)
    }
    
    func requestNextData(complete:@escaping ((Error?)->Void)) {
       
        requestExperiencesList(pageIndex: pageIndex+1).filter {
            (products) -> Bool in
            return products.count > 0
            }.subscribe(onNext: { [weak self](products) in
            if let strongSelf = self{
                let goodsCess = products.map {
                    GoodsTableViewCellViewModel(product: $0)
                }
                strongSelf.dataSource.append(contentsOf: goodsCess)
                strongSelf.pageIndex += 1
            }
            }, onError: { (error) in
                DispatchQueue.main.async {
                    print("获取数据错误")
                    complete(error)
                }
        }, onCompleted: {
            DispatchQueue.main.async {
                complete(nil)
            }
        }, onDisposed: {}).disposed(by: bag)
    }
    
    func requestExperiencesList(pageIndex: Int) -> Observable<[Product]> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return msdApiProvider.rx.request(.experiencesApi(page: pageIndex)).map([Product].self, atKeyPath: nil, using: decoder, failsOnEmptyData: false).asObservable()
        
    }
}
