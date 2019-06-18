//
//  MSDApiManager.swift
//  Test
//
//  Created by wzy on 2019/4/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import Moya

let msdApiProvider = MoyaProvider<MSDApiManager>()

enum MSDApiManager {
    case categoriesListApi
    /// Banner列表
    case galleriesApi
    /// 推荐列表
    case dealsApi(page: Int)
    /// 晒单列表
    case experiencesApi(page: Int)
    /// 搜索
    case searchApi(type: recommendType, keyWord: String, page: Int)
}

extension MSDApiManager: TargetType{
    
    var baseURL: URL {
        return URL(string: "https://www.maishoudang.com/api")!
    }
    
    
    var path: String {
        switch self {
        case .categoriesListApi:
            return "/v1/categories.json"
        case .galleriesApi:
            return "/v1/galleries.json"
        case .dealsApi:
            return "/v1/deals.json"
        case .searchApi(let type, let keyWord, _):
            switch type {
            case .deal,.deals,.Deal,.experience,.experiences,.Experience,.discovery,.discoveries,.Discovery:
                return "/v1/search.json"
            case .category:
                return "/v1/categories/\(keyWord).json"
            case .favorites:
                return "/v1/favorites.json"
            }
        case .experiencesApi:
            return "/v1/experiences.json"
        }
        
    }
    
    var method: Moya.Method{
        switch self {
        case .categoriesListApi,.galleriesApi,.dealsApi,.searchApi,.experiencesApi:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .categoriesListApi,.galleriesApi:
            return .requestPlain
        case .dealsApi(let page),.experiencesApi(let page):
            return .requestParameters(parameters: ["page":page], encoding: URLEncoding.default)
            
        case let .searchApi(type, keyWord, page):
            switch type {
            case .deal,.deals,.Deal:
                return .requestParameters(parameters: ["search_type":"deal", "page":page, "keyword":keyWord], encoding: URLEncoding.default)
                
            case .experience,.experiences,.Experience:
                return .requestParameters(parameters: ["search_type":"experience", "page":page, "keyword":keyWord], encoding: URLEncoding.default)
                
            case .discovery,.discoveries,.Discovery:
                return .requestParameters(parameters: ["search_type":"discovery", "page":page, "keyword":keyWord], encoding: URLEncoding.default)
                
            case .category,.favorites:
                return .requestParameters(parameters: ["page":page], encoding: URLEncoding.default)
            }
        }
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var headers: [String : String]?{
        return nil;
    }
    
    var sampleData: Data{
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: .utf8)!
        }
    }
}
