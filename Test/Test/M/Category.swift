//
//  Category.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

struct Category: Codable{
    var id: UInt
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    
}
