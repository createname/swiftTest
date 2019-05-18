//
//  Product.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

struct Product: Codable {
    let namePinyin: String?
    let id: UInt
    var createdAt: Date?
    let author: String?
    let name: String?
    let subtitle: String?
    let image: String?
    let publishedAt: Date?
    let merchantName: String?
    let agreeCount: UInt = 0
    let purchaseLink: String?
    let disagreeCount: UInt = 0
    let commentsCount: UInt = 0
    let favoritesCount: UInt = 0
    let type: recommendType
    
    enum CokingKeys: String, CodingKey {
        case namePinyin = "name_pinyin"
        case id
        case createdAt = "created_at"
        case author
        case name
        case subtitle
        case image
        case publishedAt = "published_at"
        case merchantName = "merchant_name"
        case agreeCount = "agree_count"
        case purchaseLink = "purchase_link"
        case disagreeCount = "disagree_count"
        case commentsCount = "comments_count"
        case favoritesCount = "favorites_count"
        case type
    }
    
}

struct Gallery: Codable {
    let id: UInt
    let title: String?
    let subtitle: String?
    let image: String
    let createdAt: Date
    let url: URL
    let articleId: String
    let articleType: recommendType
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case image
        case createdAt = "created_at"
        case url
        case articleId = "article_id"
        case articleType = "article_type"
    }
}

enum recommendType: String, Codable {
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
