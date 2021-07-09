//
//  SkillListPresenter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol SkillListPresentationLogic {
    func presentSkills(_ response: SkillListModels.FetchSkillList.Response)
}

class SkillListPresenter: SkillListPresentationLogic {
    var viewController: SkillListDisplayLogic?
    
    func presentSkills(_ response: SkillListModels.FetchSkillList.Response) {
        let skills = response.skills.map { Skill(title: $0.title.replacingOccurrences(of: " ", with: "_")) }
        
        let viewModel = SkillListModels.FetchSkillList.ViewModel(skills: skills)
        viewController?.displaySkills(viewModel)
    }
}
