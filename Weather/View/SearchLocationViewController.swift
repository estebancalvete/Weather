//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 04/05/2021.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController {
    
    //MARK: IBOultets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInputField: UITextField!
    @IBOutlet weak var setLocationButton: UIButton!
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationButton.round()
    }
    
    //MARK: IBActions
    
    @IBAction func setLocationButtonDidTouchUpInside(_ sender: Any) {
        let textToSearch = "Madrid"
        NetworkService.shared.cityName = textToSearch
        NetworkService.shared.getLocationCoordinates()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selectButtonDidTouchUpInside(_ sender: Any) {
    }
    
    //MARK: Functions
    
    public static func create() -> SearchLocationViewController {
        let storyboard = UIStoryboard(name: "SearchLocation", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! SearchLocationViewController
        return viewController
    }
}
