//
//  PostListPresenter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol PostListPresentationLogic {
    func presentPosts(_ response: PostListModels.FetchPostList.Response)
}

class PostListPresenter: PostListPresentationLogic {
    var viewController: PostListDisplayLogic?
    
    func presentPosts(_ response: PostListModels.FetchPostList.Response) {
        let posts = process(posts: response.posts)
        
        let viewModel = PostListModels.FetchPostList.ViewModel(posts: posts)
        viewController?.displayPosts(viewModel)
    }
    
    private func process(posts: [Post]) -> [Post] {
        return posts.map { post in
            Post(
                userId: post.userId,
                id: post.id,
                title: post.title.capitalized,
                body: post.body
            )
        }
    }
}
