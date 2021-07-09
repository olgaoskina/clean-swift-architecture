//
//  SkillListViewController.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol SkillListDisplayLogic {
    func displaySkills(_ viewModel: SkillListModels.FetchSkillList.ViewModel)
}

class SkillListViewController: UIViewController {
    
    var interactor: (SkillListBusinessLogic & SkillListDataStore)?
    var router: (SkillListRoutingLogic & SkillListDataPassing)?
    
    @IBOutlet weak var skillListTableView: UITableView!
    
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
        fetchSkills()
    }
    
    private func fetchSkills() {
        let request = SkillListModels.FetchSkillList.Request()
        interactor?.fetchSkills(request)
    }
    
    private func configureTableView() {
        skillListTableView.delegate = self
        skillListTableView.dataSource = self
    }
    
    private func setup() {
        let interactor = SkillListInteractor()
        let presenter = SkillListPresenter()
        let router = SkillListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
        self.router = router
        
        router.viewController = self
        router.dataStore = interactor
    }
}

extension SkillListViewController: SkillListDisplayLogic {
    func displaySkills(_ viewModel: SkillListModels.FetchSkillList.ViewModel) {
        skillListTableView.reloadData()
    }
}

extension SkillListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.skills.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let skillCell = tableView.dequeueReusableCell(withIdentifier: "SkillTableViewCell") {
            skillCell.textLabel?.text = interactor?.skills[indexPath.row].title
            
            return skillCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
