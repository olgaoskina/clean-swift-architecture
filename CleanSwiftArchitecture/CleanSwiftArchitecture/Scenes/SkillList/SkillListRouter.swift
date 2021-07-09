//
//  SkillListRouter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import UIKit

protocol SkillListRoutingLogic {
}

protocol SkillListDataPassing {
    var dataStore: SkillListDataStore? { get }
}

class SkillListRouter: SkillListRoutingLogic, SkillListDataPassing {
    weak var viewController: SkillListViewController?
    var dataStore: SkillListDataStore?
    
}
