//
//  ViewController.swift
//  Ampersand Example
//
//  Created by Stephen Anthony on 18/10/2019.
//  Copyright © 2019 Darjeeling Apps. All rights reserved.
//

import UIKit

/// A view controller showing an example of using the system
/// `+[UIFont preferredFontForTextStyle:]` API alongside Ampersand's
/// `+[UIFont applicationFontForTextStyle:]` API.
class ViewController: UITableViewController {
    private let tableDataSource = TableDataSource()
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.numberOfExamples(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableDataSource.nameForExample(at: indexPath)
        cell.textLabel?.font = tableDataSource.fontForExample(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableDataSource.title(forSection: section)
    }
}

// MARK: - Actions
extension ViewController {
    @IBAction private func changeFont(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tableDataSource.fontSource = .system
        case 1:
            tableDataSource.fontSource = .application
        default:
            fatalError("No font source for selected index \(sender.selectedSegmentIndex)")
        }
        tableView.reloadData()
    }
}
