//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 04/05/2021.
//

import UIKit
import MapKit

protocol SearchLocationViewControllerDelegate: AnyObject {
    func searchLocationViewControllerDidGetCoordinates(response: CLLocationCoordinate2D)
}
class SearchLocationViewController: UIViewController, NetworkServiceDelegate {
    
    //MARK: IBOultets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInputField: UITextField!
    @IBOutlet weak var setLocationButton: UIButton!
    
    //MARK: Variables
    
    var networkService: NetworkService? = nil
    weak var delegate: SearchLocationViewControllerDelegate?
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationButton.round()
        
        networkService = NetworkService()
        networkService?.delegate = self
    }
    
    //MARK: IBActions
    
    @IBAction func setLocationButtonDidTouchUpInside(_ sender: Any) {
        delegate?.searchLocationViewControllerDidGetCoordinates(response: mapView.centerCoordinate)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectButtonDidTouchUpInside(_ sender: Any) {
        if let textToSearch: String = locationInputField.text {
            networkService?.cityName = textToSearch
            networkService?.getLocationCoordinates()
        }
    }
    
    //MARK: Functions
    
    public static func create(delegate: SearchLocationViewControllerDelegate) -> SearchLocationViewController {
        let storyboard = UIStoryboard(name: "SearchLocation", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! SearchLocationViewController
        viewController.delegate = delegate
        return viewController
    }
    
    func networkServiceDidGetWeatherData(response: OneCallResponse?) {
        // DO NOTHING
    }
    
    func networkServiceDidGetLocationName(response: ReverseGeocodingResponse?) {
        // DO NOTHING
    }
    
    func networkServiceDidGetLocationCoordinates(response: GeocodingResponse?) {
        guard let coordinate = response?.geocodingData.first else { return }
        
        
        let center = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: CLLocationDistance(10000),
                                        longitudinalMeters: CLLocationDistance(10000))
        
        
        mapView.setRegion(region, animated: true)
    }
}
