//
//  CommentListModels.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

struct CommentListModels {
    struct FetchCommentList {
        struct Request {
        }
        
        struct Response {
            let comments: [Comment]
        }
        
        struct ViewModel {
            let comments: [Comment]
        }
    }
}
