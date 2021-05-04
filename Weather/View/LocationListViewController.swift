//
//  LocationListViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 04/05/2021.
//

import UIKit

class LocationListViewController: UIViewController {
    
    
    
    //MARK: IBOultets
    
    @IBOutlet weak var locationListTableView: UITableView!
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    
    @IBAction func searchLocationButtonDidTouchUpInside(_ sender: Any) {
        let searchLocationViewController = SearchLocationViewController.create()
        self.present(searchLocationViewController, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    public static func create() -> LocationListViewController {
        let storyboard = UIStoryboard(name: "LocationList", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! LocationListViewController
        return viewController
    }

    //MARK: UITableViewDataSource Functions
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}
