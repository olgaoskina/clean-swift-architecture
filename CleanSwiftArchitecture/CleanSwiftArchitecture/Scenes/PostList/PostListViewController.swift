//
//  PostListViewController.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol PostListDisplayLogic {
    func displayPosts(_ viewModel: PostListModels.FetchPostList.ViewModel)
}

class PostListViewController: UIViewController {
    
    var interactor: (PostListBusinessLogic & PostListDataStore)?
    var router: PostListRoutingLogic?
    
    @IBOutlet weak var postListTableView: UITableView!
    
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
        fetchPosts()
    }
    
    private func fetchPosts() {
        let request = PostListModels.FetchPostList.Request()
        interactor?.fetchPosts(request)
    }
    
    private func configureTableView() {
        postListTableView.delegate = self
        postListTableView.dataSource = self
    }
    
    private func setup() {
        let interactor = PostListInteractor()
        let presenter = PostListPresenter()
        let router = PostListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
        self.router = router
        
        router.viewController = self
        router.dataStore = interactor
    }
}

extension PostListViewController: PostListDisplayLogic {
    func displayPosts(_ viewModel: PostListModels.FetchPostList.ViewModel) {
        postListTableView.reloadData()
    }
}

extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") {
            postCell.textLabel?.text = interactor?.posts[indexPath.row].title
            
            return postCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        router?.routeToCommentList(ar: indexPath)
    }
}
