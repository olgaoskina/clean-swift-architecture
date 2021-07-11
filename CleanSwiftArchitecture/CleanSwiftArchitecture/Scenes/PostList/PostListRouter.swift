//
//  PostListRouter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol PostListRoutingLogic {
    func routeToCommentList(ar indexPath: IndexPath)
}

protocol PostListDataPassing {
    var dataStore: PostListDataStore? { get }
}

class PostListRouter: PostListRoutingLogic, PostListDataPassing {
    weak var viewController: PostListViewController?
    var dataStore: PostListDataStore?
    
    func routeToCommentList(ar indexPath: IndexPath) {
        guard
            let viewController = viewController,
            let postsDataStore = dataStore,
            let storyboard = viewController.storyboard,
            let commentsViewController = storyboard.instantiateViewController(withIdentifier: "CommentListViewController") as? CommentListViewController,
            var commentsDataSource = commentsViewController.router?.dataStore
        else { fatalError("Fail route to comment list") }
        
        passDataToCommentList(source: postsDataStore, at: indexPath, destination: &commentsDataSource)
        navigateToCommentList(source: viewController, destination: commentsViewController)
    }
    
    private func navigateToCommentList(source: PostListViewController, destination: CommentListViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func passDataToCommentList(source: PostListDataStore, at indexPath: IndexPath, destination: inout CommentListDataStore) {
        destination.post = source.posts[indexPath.row]
    }
}
