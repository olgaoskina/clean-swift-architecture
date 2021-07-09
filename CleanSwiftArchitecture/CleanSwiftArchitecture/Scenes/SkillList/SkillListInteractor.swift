//
//  SkillListInteractor.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol SkillListBusinessLogic {
    func fetchSkills(_ request: SkillListModels.FetchSkillList.Request)
}

protocol SkillListDataStore {
    var job: Job? { get set }
    var skills: [Skill] { get }
}
class SkillListInteractor: SkillListBusinessLogic, SkillListDataStore {
    var job: Job?
    var skills: [Skill] = []
    var presenter: SkillListPresentationLogic?
    
    func fetchSkills(_ request: SkillListModels.FetchSkillList.Request) {
        // TODO: fetch skills
        skills = [
            Skill(title: "Skill 1"),
            Skill(title: "Skill 2"),
            Skill(title: "Skill 3")
        ]
        
        let response = SkillListModels.FetchSkillList.Response(skills: skills)
        presenter?.presentSkills(response)
    }
}
