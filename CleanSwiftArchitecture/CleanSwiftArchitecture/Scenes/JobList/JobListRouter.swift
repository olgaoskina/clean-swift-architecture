//
//  JobListRouter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol JobListRoutingLogic {
    func routeToSkillList(ar indexPath: IndexPath)
}

protocol JobListDataPassing {
    var dataStore: JobListDataStore? { get }
}

class JobListRouter: JobListRoutingLogic, JobListDataPassing {
    weak var viewController: JobListViewController?
    var dataStore: JobListDataStore?
    
    func routeToSkillList(ar indexPath: IndexPath) {
        guard
            let viewController = viewController,
            let jobsDataStore = dataStore,
            let storyboard = viewController.storyboard,
            let skillsViewController = storyboard.instantiateViewController(withIdentifier: "SkillListViewController") as? SkillListViewController,
            var skillsDataSource = skillsViewController.router?.dataStore
        else { fatalError("Fail route to skill list") }
        
        passDataToSkillList(source: jobsDataStore, at: indexPath, destination: &skillsDataSource)
        navigateToSkillList(source: viewController, destination: skillsViewController)
    }
    
    private func navigateToSkillList(source: JobListViewController, destination: SkillListViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func passDataToSkillList(source: JobListDataStore, at indexPath: IndexPath, destination: inout SkillListDataStore) {
        destination.job = source.jobs[indexPath.row]
    }
}
