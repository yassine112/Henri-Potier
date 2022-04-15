//
//  Book.swift
//  Henri Potier
//
//  Created by YEH on 14/4/2022.
//

import Foundation

enum Book {
    
    typealias Response  = [ResponseItem]
    
    struct ResponseItem: Codable {
        let isbn        : String
        let title       : String
        let price       : Int
        let cover       : String
        let synopsis    : [String]
    }
    
}
