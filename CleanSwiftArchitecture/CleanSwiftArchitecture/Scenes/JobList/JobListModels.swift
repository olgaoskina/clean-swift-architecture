//
//  JobListModels.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

struct JobListModels {
    struct FetchJobList {
        struct Request {
        }
        
        struct Response {
            let jobs: [Job]
        }
        
        struct ViewModel {
            let jobs: [Job]
        }
    }
}
