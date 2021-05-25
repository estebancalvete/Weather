
import UIKit
import MapKit

protocol LocationListViewControllerDelegate: AnyObject {
    func locationListViewControllerDidSelectCity(city: GeocodingData)
}

class LocationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkServiceDelegate, SearchLocationViewControllerDelegate {
    
    
    //MARK: Variables
    
    var networkService: NetworkService? = nil
    var cityList: [GeocodingData] = []
    var cityListPersistent: [LocationPersistent] = []
    weak var delegate: LocationListViewControllerDelegate?
    
    
    //MARK: IBOultets
    
    @IBOutlet weak var locationListTableView: UITableView!
    
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<LocationPersistent>.self, from: data)
            if array != nil {
                cityListPersistent = array!
            }
        }
        
        locationListTableView.dataSource = self
        locationListTableView.delegate = self
        networkService = NetworkService()
        networkService?.delegate = self
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
    
    //MARK: Private functions
    
    private func saveOnUserDefaults(geoData: GeocodingData) {
        let locationPersistent = LocationPersistent(name: geoData.name,
                                                    country: geoData.country,
                                                    lat: geoData.lat,
                                                    lon: geoData.lon)

        var locationPeristents: [LocationPersistent] = []
        
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<LocationPersistent>.self, from: data)

            if array != nil {
                locationPeristents.append(contentsOf: array!)
                locationPeristents.append(locationPersistent)
            } else {
                locationPeristents.append(locationPersistent)
            }
        }
        UserDefaults.standard.set(try? JSONEncoder().encode(locationPeristents), forKey: "SavedLocations")
        
        cityListPersistent = locationPeristents
    }
    
    
    //MARK: SearchLocationViewControllerDelegate Functions
    
    func searchLocationViewControllerDidGetCoordinates(response: CLLocationCoordinate2D) {
        networkService?.latitude = NSNumber(value: response.latitude).stringValue
        networkService?.longitude = NSNumber(value: response.longitude).stringValue
        networkService?.getLocationName()
    }
    
    
    //MARK: NetworkServiceDelegate Functions
    
    func networkServiceDidGetWeatherData(response: OneCallResponse?) {
        // DO NOTHING
    }
    
    func networkServiceDidGetLocationName(response: ReverseGeocodingResponse?) {
        guard let cityDetails = response?.geocodingData.first else { return }
        saveOnUserDefaults(geoData: cityDetails)
        
        
        cityList.append(cityDetails)
        locationListTableView.reloadData()
    }
    
    func networkServiceDidGetLocationCoordinates(response: GeocodingResponse?) {
        // DO NOTHING
    }
    
    
    //MARK: UITableViewDataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListPersistent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListTableViewCell", for: indexPath) as! LocationListTableViewCell
        let cityName = cityListPersistent[indexPath.row].name
        let countryCode = cityListPersistent[indexPath.row].country
        cell.configure(cityName: cityName, countryCode: countryCode)
        return cell
    }
    
    
    //MARK: UITableViewDelegate Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        delegate?.locationListViewControllerDidSelectCity(city: city)
        self.dismiss(animated: true, completion: nil)
    }
}
