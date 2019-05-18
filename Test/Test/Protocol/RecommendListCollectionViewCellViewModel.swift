//
//  RecommendListCollectionViewCellViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

protocol RecommendListCollectionViewCellViewModel: CellViewModelProtocol {
    var dataSource: [CellViewModelProtocol] {get set}
    
    func requestNewData(complete:@escaping ((Error?) -> Void))
    
    func requestNextPageData(complete:@escaping ((Error?) -> Void))
}
