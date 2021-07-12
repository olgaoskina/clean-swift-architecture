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
    
    private let worker = PostListWorker()
    
    func fetchPosts(_ request: PostListModels.FetchPostList.Request) {
        worker.fetchPostList(with: PostListParams()) { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                let response = PostListModels.FetchPostList.Response(posts: posts)
                self.presenter?.presentPosts(response)
            case .failure(_):
                // TODO: show error
                self.posts = []
                let response = PostListModels.FetchPostList.Response(posts: [])
                self.presenter?.presentPosts(response)
            }
        }
    }
}
