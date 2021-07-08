//
//  JobListViewController.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol JobListDisplayLogic {
    func displayJobs(_ viewModel: JobListModels.FetchJobList.ViewModel)
}

class JobListViewController: UIViewController {
    
    var interactor: JobListBusinessLogic?
    var router: JobListRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let interactor = JobListInteractor()
        let presenter = JobListPresenter()
        let router = JobListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
        self.router = router
        
        router.viewController = self
        router.dataStore = interactor
    }
}

extension JobListViewController: JobListDisplayLogic {
    func displayJobs(_ viewModel: JobListModels.FetchJobList.ViewModel) {
        
    }
}
