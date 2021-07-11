//
//  CommentListRouter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol CommentListRoutingLogic {
}

protocol CommentListDataPassing {
    var dataStore: CommentListDataStore? { get }
}

class CommentListRouter: CommentListRoutingLogic, CommentListDataPassing {
    weak var viewController: CommentListViewController?
    var dataStore: CommentListDataStore?
    
}
