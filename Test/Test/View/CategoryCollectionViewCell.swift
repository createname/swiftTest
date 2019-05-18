//
//  CategoryCollectionViewCell.swift
//  Test
//
//  Created by wzy on 2019/4/27.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, CellBindViewModelProtocol {
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(with vm: CellViewModelProtocol) {
        let categoryVM = vm as! CategoryCollectionViewCellViewModel
        name.text = categoryVM.category.name
        
    }

}
