//
//  JobListRouter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol JobListRoutingLogic {
    func routeToDetail()
}

protocol JobListDataPassing {
    var dataStore: JobListDataStore? { get }
}

class JobListRouter: JobListRoutingLogic, JobListDataPassing {
    weak var viewController: JobListViewController?
    var dataStore: JobListDataStore?
    
    func routeToDetail() {
        
    }
}
