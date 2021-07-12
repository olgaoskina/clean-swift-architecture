//
//  PostResult.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import Foundation

struct PostResult: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
