//
//  HandyProduct.swift
//  Test
//
//  Created by wzy on 2019/6/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import HandyJSON

class HandyProduct: HandyJSON {
    
    var namePinyin: String?
    var id: Int?
    var createdAt: Date?
    var author: String?
    var name: String?
    var subtitle: String?
    var image: String?
    var publishedAt: Date?
    var merchantName: String?
    var agreeCount: Int = 0
    var purchaseLink: String?
    var disagreeCount: Int = 0
    var commentsCount: Int = 0
    var favoritesCount: Int = 0
    var type: HandyRecommendType!
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &createdAt, name: "created_at")
        mapper.specify(property: &namePinyin, name: "name_pinyin")
        mapper.specify(property: &publishedAt, name: "published_at")
        mapper.specify(property: &agreeCount, name: "agree_count")
        mapper.specify(property: &purchaseLink, name: "purchase_link")
        mapper.specify(property: &disagreeCount, name: "disagree_count")
        mapper.specify(property: &commentsCount, name: "comments_count")
        mapper.specify(property: &favoritesCount, name: "favorites_count")
        
    }
    required init() {

    }
}
enum HandyRecommendType: String, HandyJSONEnum {
    
    case deals
    case deal
    case Deal
    
    case experience
    case experiences
    case Experience
    
    case discovery
    case discoveries
    case Discovery
    
    case category
    case favorites
    
}
