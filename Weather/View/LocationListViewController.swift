//
//  LocationListViewController.swift
//  Weather
//
//

import UIKit

class LocationListViewController: UIViewController {
    
    public static func create() -> LocationListViewController {
        let storyboard = UIStoryboard(name: "LocationList", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! LocationListViewController
        return viewController
    }
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchButtonDidTouchUpInside(_ sender: Any) {
        let vc = SearchLocationViewController.create()
        self.present(vc, animated: true, completion: nil)
    }
}
