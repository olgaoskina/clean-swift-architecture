//
//  SkillListModels.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

struct SkillListModels {
    struct FetchSkillList {
        struct Request {
        }
        
        struct Response {
            let skills: [Skill]
        }
        
        struct ViewModel {
            let skills: [Skill]
        }
    }
}
