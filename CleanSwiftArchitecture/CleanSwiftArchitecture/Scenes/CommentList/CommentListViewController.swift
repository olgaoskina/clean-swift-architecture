//
//  CommentListViewController.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol CommentListDisplayLogic {
    func displayComments(_ viewModel: CommentListModels.FetchCommentList.ViewModel)
}

class CommentListViewController: UIViewController {
    
    var interactor: (CommentListBusinessLogic & CommentListDataStore)?
    var router: (CommentListRoutingLogic & CommentListDataPassing)?
    
    @IBOutlet weak var commentListTableView: UITableView!
    
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
        fetchComments()
    }
    
    private func fetchComments() {
        let request = CommentListModels.FetchCommentList.Request()
        interactor?.fetchComments(request)
    }
    
    private func configureTableView() {
        commentListTableView.delegate = self
        commentListTableView.dataSource = self
    }
    
    private func setup() {
        let interactor = CommentListInteractor()
        let presenter = CommentListPresenter()
        let router = CommentListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
        self.router = router
        
        router.viewController = self
        router.dataStore = interactor
    }
}

extension CommentListViewController: CommentListDisplayLogic {
    func displayComments(_ viewModel: CommentListModels.FetchCommentList.ViewModel) {
        commentListTableView.reloadData()
    }
}

extension CommentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") {
            commentCell.textLabel?.text = interactor?.comments[indexPath.row].title
            
            return commentCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
