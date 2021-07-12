//
//  CommentResult.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import Foundation

struct CommentResult: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
