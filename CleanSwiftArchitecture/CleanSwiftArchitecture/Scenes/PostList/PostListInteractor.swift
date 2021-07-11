//
//  PostListInteractor.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol PostListBusinessLogic {
    func fetchPosts(_ request: PostListModels.FetchPostList.Request)
}

protocol PostListDataStore {
    var posts: [Post] { get }
}
class PostListInteractor: PostListBusinessLogic, PostListDataStore {
    var posts: [Post] = []
    var presenter: PostListPresentationLogic?
    
    func fetchPosts(_ request: PostListModels.FetchPostList.Request) {
        // TODO: fetch posts
        posts = [
            Post(title: "Post 1"),
            Post(title: "Post 2"),
            Post(title: "Post 3")
        ]
        
        let response = PostListModels.FetchPostList.Response(posts: posts)
        presenter?.presentPosts(response)
    }
}
