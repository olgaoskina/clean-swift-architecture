//
//  JobListInteractor.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol JobListBusinessLogic {
    func fetchJobs(_ request: JobListModels.FetchJobList.Request)
}

protocol JobListDataStore {
    var jobs: [Job] { get }
}
class JobListInteractor: JobListBusinessLogic, JobListDataStore {
    var jobs: [Job] = []
    var presenter: JobListPresentationLogic?
    
    func fetchJobs(_ request: JobListModels.FetchJobList.Request) {
        // TODO: fetch jobs
        jobs = [
            Job(title: "Job 1"),
            Job(title: "Job 2"),
            Job(title: "Job 3")
        ]
        
        let response = JobListModels.FetchJobList.Response(jobs: jobs)
        presenter?.presentJobs(response)
    }
}
