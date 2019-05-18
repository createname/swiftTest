//
//  GoodPriceTableViewCellViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/27.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

struct GoodPriceTableViewCellViewModel:CellViewModelProtocol {
    func cellReuseIdentifier() -> String {
        return "GoodPriceTableViewCell"
    }
    
    var product: Product
    
    var sourceAndTime: String {
        return "\(product.merchantName ?? "") | \(String(describing: product.publishedAt?.compareCurrentTime()))"
    }
    
    func cellSelected() {
        
    }
}
