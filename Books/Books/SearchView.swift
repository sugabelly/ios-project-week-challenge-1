//
//  ViewController.swift
//  Books
//
//  Created by Lotanna Igwe-Odunze on 1/10/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import UIKit

class SearchView: UIViewController, UISearchBarDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    var faveList: PotterList!
    var selection: Character?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func faveButton(_ sender: UIButton) {
        if let favourite = Importer.shared.character {
        
       HogwartsController.hogwarts.append(favourite)
            faveList.tableView.reloadData()
        }
    }
    
    func selectedView() {
        nameLabel.text = selection?.name
        speciesLabel.text = selection?.species
        roleLabel.text = selection?.role
        houseLabel.text = selection?.house
        statusLabel.text = selection?.bloodStatus
    }
    

    func updateViews() {
        
        if let selected = Importer.shared.character {
        nameLabel.text = selected.name
        speciesLabel.text = selected.species
        roleLabel.text = selected.role
        houseLabel.text = selected.house
        statusLabel.text = selected.bloodStatus
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return } //Unwrap the search term.
        
        //Below is the JSON action that pulls the searched term from the API.
         Importer.shared.grabHarry(query: searchTerm, completion: { (_) in
           
            DispatchQueue.main.async {
        
                self.updateViews() }
            
        }) //End of Fetch command.
        
        
        
    }
    

}
