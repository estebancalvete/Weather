
import UIKit
import MapKit

protocol LocationListViewControllerDelegate: AnyObject {
    func locationListViewControllerDidSelectCity(city: GeocodingData)
}

class LocationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkServiceDelegate, SearchLocationViewControllerDelegate {
    
    
    //MARK: Variables
    
    var networkService: NetworkService? = nil
    var cityListPersistent: [GeocodingData] = []
    weak var delegate: LocationListViewControllerDelegate?
    
    
    //MARK: IBOultets
    
    @IBOutlet weak var locationListTableView: UITableView!
    
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<GeocodingData>.self, from: data)
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
    
    @IBAction func editTableButtonDidTuchUpInside(_ sender: Any) {
        if locationListTableView.isEditing == true {
            locationListTableView.isEditing = false
        } else {
            locationListTableView.isEditing = true
        }
    }
    
    //MARK: Functions
    
    public static func create(delegate: LocationListViewControllerDelegate) -> LocationListViewController {
        let storyboard = UIStoryboard(name: "LocationList", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! LocationListViewController
        viewController.delegate = delegate
        return viewController
    }
    
    
    //MARK: Private functions
    
    private func saveOnUserDefaults(cityDetails: GeocodingData) {
        var locationPersistents: [GeocodingData] = []
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<GeocodingData>.self, from: data)
            if array != nil {
                locationPersistents.append(contentsOf: array!)
            }
        }
        let isContained: Bool = locationPersistents.contains { (geoData) -> Bool in
            return geoData.name == cityDetails.name
        }
        if !isContained {
            locationPersistents.append(cityDetails)
            UserDefaults.standard.set(try? JSONEncoder().encode(locationPersistents), forKey: "SavedLocations")
            cityListPersistent = locationPersistents
        }
    }
    
    private func deleteOnUserDefaults(cityDetails: GeocodingData) {
        var locationPersistents: [GeocodingData] = []
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<GeocodingData>.self, from: data)
            if array != nil {
                locationPersistents.append(contentsOf: array!)
            }
        }
        let newArray = locationPersistents.filter { (geoData) -> Bool in
            return geoData.name != cityDetails.name
        }
        UserDefaults.standard.set(try? JSONEncoder().encode(newArray), forKey: "SavedLocations")
        cityListPersistent = newArray
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
        saveOnUserDefaults(cityDetails: cityDetails)
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
        let city = cityListPersistent[indexPath.row]
        delegate?.locationListViewControllerDidSelectCity(city: city)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteOnUserDefaults(cityDetails: cityListPersistent[indexPath.row])
            locationListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var locationPersistents: [GeocodingData] = []
        if let data = UserDefaults.standard.value(forKey: "SavedLocations") as? Data {
            let array = try? JSONDecoder().decode(Array<GeocodingData>.self, from: data)
            if array != nil {
                locationPersistents.append(contentsOf: array!)
            }
        }
        let itemToMove = locationPersistents[sourceIndexPath.row]
        locationPersistents.remove(at: sourceIndexPath.row)
        locationPersistents.insert(itemToMove, at: destinationIndexPath.row)
        UserDefaults.standard.set(try? JSONEncoder().encode(locationPersistents), forKey: "SavedLocations")
        cityListPersistent = locationPersistents
        tableView.reloadData()
    }
}
