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

        guard let date: Date = product.publishedAt else {
            return ""
        }
        return date.dateTime(format: "MM-dd")
    }
    
    func cellReuseIdentifier() -> String {
        return "GoodsTableViewCell"
    }
    
    func cellSelected() {
        
    }
}
