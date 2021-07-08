//
//  JobListPresenter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol JobListPresentationLogic {
    func presentJobs(_ response: JobListModels.FetchJobList.Response)
}

class JobListPresenter: JobListPresentationLogic {
    var viewController: JobListDisplayLogic?
    
    func presentJobs(_ response: JobListModels.FetchJobList.Response) {
        let jobs = response.jobs.map { Job(title: $0.title.replacingOccurrences(of: " ", with: "-")) }
        
        let viewModel = JobListModels.FetchJobList.ViewModel(jobs: jobs)
        viewController?.displayJobs(viewModel)
    }
}
