//
//  MasterViewController.swift
//  CandySearch
//
//  Created by 이현호 on 2021/06/08.
//

import UIKit

class MasterViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var candies: [Candy] = []
    var filteredCandies: [Candy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        candies = Candy.candies()
        
        setSearchController()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setSearchController() {
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
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Candy
                candy = searchController.isActive ? filteredCandies[(indexPath.row)] : candies[(indexPath.row)]
                let controller = segue.destination as! DetailViewController
                controller.detailCandy = candy
            }
        }
    }
    
    private func filterContentForSearchText(_ searchKeyword: String, scope: String = "All") {
        filteredCandies = candies.filter { candy in
            if scope != candy.category.rawValue && scope != "All" { return false }
            return candy.name.lowercased().contains(searchKeyword.lowercased()) || searchKeyword == ""
        }
        tableView.reloadData()
    }
}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        guard let serachKeyword = searchController.searchBar.text else { return }
        filterContentForSearchText(serachKeyword, scope: scope)
    }
}


extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredCandies.count : candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandyCell", for: indexPath)
        let candy: Candy
        
        candy = searchController.isActive ? filteredCandies[indexPath.row] : candies[indexPath.row]
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category.rawValue

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
