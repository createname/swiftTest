//
//  CategoryCollectionViewCellViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import UIKit

struct CategoryCollectionViewCellViewModel: CellViewModelProtocol {
    var category: Category
    
    func cellReuseIdentifier() -> String {
        return "CategoryCollectionViewCell"
    }
    
    func cellSize() -> CGSize {
        let name = category.name
        
        if !name.isEmpty{
            let attributeStr = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
            let size = attributeStr.boundingRect(with: .zero, options: .usesLineFragmentOrigin, context: nil).size
            return CGSize(width: size.width+5, height: size.height)
            
        }
        
        return .zero
        
    }
}
