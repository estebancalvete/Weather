
import UIKit
import MapKit

protocol SearchLocationViewControllerDelegate: AnyObject {
    func searchLocationViewControllerDidGetCoordinates(response: CLLocationCoordinate2D)
}

class SearchLocationViewController: UIViewController, UITextFieldDelegate, NetworkServiceDelegate {
    
    
    //MARK: Variables
    
    var networkService: NetworkService? = nil
    weak var delegate: SearchLocationViewControllerDelegate?
    
    
    //MARK: IBOultets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInputField: UITextField!
    @IBOutlet weak var setLocationButton: UIButton!
    
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationInputField.delegate = self
        networkService = NetworkService()
        networkService?.delegate = self
        setLocationButton.round()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textToSearch: String = locationInputField.text {
            networkService?.cityName = textToSearch
            networkService?.getLocationCoordinates()
        }
        return true
    }
    
    //MARK: LocationServiceDelegate Functions
    
    func networkServiceDidGetWeatherData(response: OneCallResponse?) {
        // DO NOTHING
    }
    
    func networkServiceDidGetLocationName(response: ReverseGeocodingResponse?) {
        // DO NOTHING
    }
    
    func networkServiceDidGetLocationCoordinates(response: GeocodingResponse?) {
        guard let coordinates = response?.geocodingData.first else { return }
        let mapCenter = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lon)
        let mapRegion = MKCoordinateRegion(center: mapCenter, latitudinalMeters: 25000, longitudinalMeters: 25000)
        mapView.setRegion(mapRegion, animated: true)
    }
    
    
    //MARK: Functions
    
    public static func create(delegate: SearchLocationViewControllerDelegate) -> SearchLocationViewController {
        let storyboard = UIStoryboard(name: "SearchLocation", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! SearchLocationViewController
        viewController.delegate = delegate
        return viewController
    }
}
