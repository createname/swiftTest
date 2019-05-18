//
//  CellViewModelProtocol.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import UIKit

protocol CellViewModelProtocol {
    func cellReuseIdentifier() -> String
    
    func cellSelected()
    
    func cellHeight() -> Float
}

extension CellViewModelProtocol {
    func cellSelected() {
        
    }
    func cellHeight() -> Float {
        return 0
    }
    
    func cellSize() -> CGSize {
        return CGSize.zero
    }
}
