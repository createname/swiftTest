//
//  BaseCategoryViewModelProtocol.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

protocol BaseCategoryViewModelProtocol {
    var categoriesDataSource: [CellViewModelProtocol] {get set}
    
    var categoriesListDataSource: [CellViewModelProtocol] {get set}
    
    func requestNesData(complete:@escaping ((Error?) -> Void))
}
