//
//  DTOToDomainConverter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import Foundation

struct DTOToDomainConverter {
    func postList(from postResults: [PostResult]) -> [Post] {
        return postResults.compactMap { postResult in
            return Post(
                userId: postResult.userId,
                id: postResult.id,
                title: postResult.title,
                body: postResult.body
            )
        }
    }
    
    func commentList(from commentResults: [CommentResult]) -> [Comment] {
        return commentResults.compactMap { commentResult in
            return Comment(
                postId: commentResult.postId,
                id: commentResult.id,
                name: commentResult.name,
                email: commentResult.email,
                body: commentResult.body
            )
        }
    }
}
