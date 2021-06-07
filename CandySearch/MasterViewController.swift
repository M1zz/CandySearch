//
//  MasterViewController.swift
//  CandySearch
//
//  Created by 이현호 on 2021/06/08.
//

import UIKit

class MasterViewController: UIViewController, UISearchBarDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.candyGreen()], for:.selected)
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.white], for:.normal)    
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController

       
    }


}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    
}
