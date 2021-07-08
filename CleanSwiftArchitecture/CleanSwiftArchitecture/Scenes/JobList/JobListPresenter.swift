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
        
    }
}
