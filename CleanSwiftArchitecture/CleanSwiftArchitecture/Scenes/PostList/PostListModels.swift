//
//  PostListModels.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

struct PostListModels {
    struct FetchPostList {
        struct Request {
        }
        
        struct Response {
            let posts: [Post]
        }
        
        struct ViewModel {
            let posts: [Post]
        }
    }
}
