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
    
    var interactor: (JobListBusinessLogic & JobListDataStore)?
    var router: JobListRoutingLogic?
    
    @IBOutlet weak var jobListTableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchJobs()
    }
    
    private func fetchJobs() {
        let request = JobListModels.FetchJobList.Request()
        interactor?.fetchJobs(request)
    }
    
    private func configureTableView() {
        jobListTableView.delegate = self
        jobListTableView.dataSource = self
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
        jobListTableView.reloadData()
    }
}

extension JobListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.jobs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let jobCell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") {
            jobCell.textLabel?.text = interactor?.jobs[indexPath.row].title
            
            return jobCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        router?.routeToDetail()
    }
}
