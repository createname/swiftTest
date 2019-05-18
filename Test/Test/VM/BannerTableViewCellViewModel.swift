//
//  BannerTableViewCellViewModel.swift
//  Test
//
//  Created by wzy on 2019/4/25.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

struct BannerTableViewCellViewModel: CellViewModelProtocol {
    func cellReuseIdentifier() -> String {
        return "BannerTableViewCell"
    }
    
    var galleries: [Gallery]
    
    var galleryCovers: [String] {
        return galleries.map({$0.image})
    }
    
    var galleryTitles: [String] {
        return galleries.map({$0.title ?? ""})
    }
    
    func cellSelected() {
        
    }
    
}
