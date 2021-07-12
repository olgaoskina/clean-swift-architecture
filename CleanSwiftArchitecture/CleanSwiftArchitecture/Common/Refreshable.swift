//
//  Refreshable.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import UIKit

@objc protocol Refreshable {
    @objc func refresh()
}

extension Refreshable {
    func addRefreshControl(to scrollView: UIScrollView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        scrollView.refreshControl = refreshControl
    }
}
