import Foundation

class WeatherManager: ObservableObject {
    let apiKey = "2b40b2604cf77ad0deb0a05d9023ab33"

    func fetchWeather(for city: String, completion: @escaping (WeatherData?) -> Void) {
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=tr"

        print("Veri çekiliyor...")
        print("URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            print("Sunucudan veri geldi: \(data?.count ?? 0) bayt")

            guard let data = data else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            if let weather = try? decoder.decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    print("✅ Veri başarıyla çözüldü: \(weather)")
                    completion(weather)
                }
            } else {
                print("❌ Decode başarısız oldu.")
                completion(nil)
            }
        }.resume()
    }
}
