//
//  GoodsTableViewCellViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/25.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

struct GoodsTableViewCellViewModel: CellViewModelProtocol {
    var product: Product
    
    var time: String{
        return product.publishedAt!.dateTime(format: "MM-dd")
    }
    
    func cellReuseIdentifier() -> String {
        return "GoodsTableViewCell"
    }
    
    func cellSelected() {
        
    }
}
