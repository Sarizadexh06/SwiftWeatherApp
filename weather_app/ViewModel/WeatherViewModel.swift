import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = ""
    @Published var description: String = ""

    let apiKey = "1880cbee68938bd75183a8d700cc3b32"

    func fetchWeather(for city: String) {
        let cityFormatted = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityFormatted)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.temperature = "\(decodedData.main.temp)°C"
                        self.description = decodedData.weather.first?.description ?? "Bilinmiyor"
                    }
                } catch {
                    print("JSON decode hatası:", error.localizedDescription)
                }
            }
        }.resume()
    }
}
