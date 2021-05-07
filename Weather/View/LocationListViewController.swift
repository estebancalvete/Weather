//
//  LocationListViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 04/05/2021.
//

import UIKit
import MapKit

protocol LocationListViewControllerDelegate: AnyObject {
    func locationListViewControllerDidSelectCoordinate(coordinate: CLLocationCoordinate2D)
}
class LocationListViewController: UIViewController, SearchLocationViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: IBOultets
    
    @IBOutlet weak var locationListTableView: UITableView!
    
    //MARK: Variables
    
    var coordinates: [CLLocationCoordinate2D] = []
    weak var delegate: LocationListViewControllerDelegate?
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationListTableView.dataSource = self
        locationListTableView.delegate = self
    }
    
    //MARK: IBActions
    
    @IBAction func searchLocationButtonDidTouchUpInside(_ sender: Any) {
        let searchLocationViewController = SearchLocationViewController.create(delegate: self)
        self.present(searchLocationViewController, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    public static func create(delegate: LocationListViewControllerDelegate) -> LocationListViewController {
        let storyboard = UIStoryboard(name: "LocationList", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! LocationListViewController
        viewController.delegate = delegate
        return viewController
    }
    
    //MARK: SearchLocationViewControllerDelegate Functions
    
    func searchLocationViewControllerDidGetCoordinates(response: CLLocationCoordinate2D) {
        coordinates.append(response)
        locationListTableView.reloadData()
    }

    //MARK: UITableViewDataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListTableViewCell", for: indexPath) as! LocationListTableViewCell
        
        let latitude = NSNumber(value: coordinates[indexPath.row].latitude).stringValue
        let longitude = NSNumber(value: coordinates[indexPath.row].longitude).stringValue
        
        cell.configure(latitude: latitude, longitude: longitude)
        
        return cell
    }
    
    //MARK: UITableViewDelegate Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinate = coordinates[indexPath.row]
        delegate?.locationListViewControllerDidSelectCoordinate(coordinate: coordinate)
        self.dismiss(animated: true, completion: nil)
    }
}
