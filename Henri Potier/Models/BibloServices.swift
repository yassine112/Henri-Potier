//
//  BibloServices.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 14/4/2022.
//

import Foundation
import Moya

enum BibloServices {
    case getList
    case commercialOffers(isbn: String)
}

extension BibloServices: TargetType {
    
    var baseURL: URL { URL(string: "https://henri-potier.techx.fr/books")! }
    
    var path: String {
        switch self {
            case .getList: return "/"
            case .commercialOffers(let isbn): return "/\(isbn)/commercialOffers"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
