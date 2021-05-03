//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 3/5/21.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInputTextField: UITextField!
    
    //MARK: Initializer
    
    public static func create() -> SearchLocationViewController {
        let storyboard = UIStoryboard(name: "SearchLocation", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! SearchLocationViewController
        return viewController
    }
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: IBActions
    @IBAction func searchButtonDidTouchUpInside(_ sender: Any) {
        
        let textToSearch = "Madrid"
    }
    
    @IBAction func addButtonDidTouchUpInside(_ sender: Any) {
    }
}
