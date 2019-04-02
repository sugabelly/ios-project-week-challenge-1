//
//  PotterList.swift
//  Books
//
//  Created by Lotanna Igwe-Odunze on 1/10/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import Foundation
import UIKit
class PotterList: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HogwartsController.hogwarts.count    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "potterCell", for: indexPath)
        cell.textLabel?.text = HogwartsController.hogwarts[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searcher" {
            let searchVC = segue.destination as! SearchView
            
            searchVC.faveList = self
        }
        else if segue.identifier == "viewer" {
            let detailVC = segue.destination as! SearchView
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.selection = HogwartsController.hogwarts[indexPath.row]
            DispatchQueue.main.async {
                detailVC.selectedView() }
        }
    }
}
