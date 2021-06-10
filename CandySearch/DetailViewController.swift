//
//  DetailViewController.swift
//  CandySearch
//
//  Created by 이현호 on 2021/06/09.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var candyImageView: UIImageView!
    
    var detailCandy: Candy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.backgroundColor = .candyGreen()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .candyGreen()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setDisplay() {
        candyImageView.image = UIImage(named: detailCandy?.name ?? "")
        title = detailCandy?.name
    }
}
