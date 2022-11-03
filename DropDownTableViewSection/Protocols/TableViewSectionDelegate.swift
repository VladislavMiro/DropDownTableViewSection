//
//  TableViewSectionDelegate.swift
//  TableView
//
//  Created by Vladislav Miroshnichenko on 03.11.2022.
//

import Foundation

protocol TableViewSectionDelegate: class {    
    func showSection(inSection: Int)
    func hideSetion(inSection: Int)
}
