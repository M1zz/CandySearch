//
//  MasterViewController.swift
//  CandySearch
//
//  Created by 이현호 on 2021/06/08.
//

import UIKit

class MasterViewController: UIViewController, UISearchBarDelegate {

    var candies: [Candy] = []
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candies = Candy.candies()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.candyGreen()], for:.selected)
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.white], for:.normal)    
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        
        //navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Candy
                candy = candies[(indexPath.row)]
                
                let controller = segue.destination as! DetailViewController
                controller.detailCandy = candy
            }
        }
    }
}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandyCell", for: indexPath)
        let candy: Candy
        candy = candies[indexPath.row]
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category.rawValue

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
