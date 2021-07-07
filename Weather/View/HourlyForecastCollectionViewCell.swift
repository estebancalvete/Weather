
import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var hourOfDayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var hourlyTempLabel: UILabel!
    
    
    //MARK: Functions
    
    func configure(data: HourlyWeather, timeOffset: Double) {
        hourlyTempLabel.text = String(format: "%.0f", data.temp) + " ºC"
        weatherImage.image = UIImage(named: data.weather.first?.icon ?? "01d")
        let time = Date(timeIntervalSince1970: (data.dt + timeOffset))
        hourOfDayLabel.text = hourOfDay(date: time)
    }
    
    private func hourOfDay(date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "h a"
        return dayFormatter.string(from: date)
    }
}

