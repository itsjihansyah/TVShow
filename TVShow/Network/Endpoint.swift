//
//  Endpoint.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

enum Endpoint {
    case showList,
         showDetail(_ id: Int)
    
    private var path : String {
        switch self {
        case .showList: return "/shows"
        case .showDetail(let id): return "/shows/\(id)"
        }
    }
    
    var fullpath : String {
        Constants.apiBaseURL + path
    }
}
