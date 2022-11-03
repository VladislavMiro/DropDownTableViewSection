//
//  TableViewController.swift
//  TableView
//
//  Created by Vladislav Miroshnichenko on 29.10.2022.
//

import UIKit

@IBDesignable class TableViewController: UITableViewController {

    private let data = ["A", "A1", "A2", "B", "B1", "B2", "C", "C1", "C2", "D", "D1", "D2", "E", "E1", "E2", "F", "F1", "F2", "G", "G1", "G2"]
    private var preparedData = [String:[String]]()
    private let cellIdentifire = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewComfigure()
        prepareData()

    }
    
    private func tableViewComfigure() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
        self.clearsSelectionOnViewWillAppear = true
    }
    
    private func prepareData() {
        for item in SectionNames.allCases {
            preparedData["\(item.rawValue)"] = data.filter({ data -> Bool in
                return data.contains(item.rawValue)
            })
        }
    }

}

//MARK: TableViewDataSource implementation

extension TableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return preparedData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let data = preparedData[SectionNames.allCases[section].rawValue] else { return 0 }
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)

        if let data = preparedData["\(SectionNames.allCases[indexPath.section])"]?[indexPath.row] {
            cell.textLabel?.text = data
        }

        return cell
    }
    
}

//MARK: Section view settings

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionNames.allCases[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customSection = Section()
        let text = SectionNames.allCases[section].rawValue
        
        customSection.label.text = text
        customSection.sectionNumber = section
        customSection.delegate = self
        
        return customSection
    }
    
}

//MARK: TableViewSectionDelegateImplementation

extension TableViewController: TableViewSectionDelegate {
    
    public func showSection(inSection: Int) {
        let sectionName = SectionNames.allCases[inSection].rawValue
        var indexPaths = [IndexPath]()
        let data = self.data.filter { $0.contains(sectionName) }
        
        for index in data.indices {
            indexPaths.append(.init(item: index, section: inSection))
        }
        
        tableView.beginUpdates()

        preparedData[sectionName] = data
        tableView.insertRows(at: indexPaths, with: .fade)
        
        tableView.endUpdates()
    }
    
    public func hideSetion(inSection: Int) {
        var indexPaths = [IndexPath]()
        
        for index in 0..<tableView.numberOfRows(inSection: inSection) {
            indexPaths.append(.init(row: index, section: inSection))
        }
        
        tableView.beginUpdates()
        
        if preparedData[SectionNames.allCases[inSection].rawValue]?.removeAll() != nil {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        
        tableView.endUpdates()
    }
    
    
}
