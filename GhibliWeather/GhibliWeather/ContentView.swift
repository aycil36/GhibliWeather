import SwiftUI
import AVKit
import AVFoundation
import Foundation

struct ContentView: View {
    @State private var city: String = ""
    @State private var weather: WeatherData?
    let weatherManager = WeatherManager()

    @State private var isMusicPlaying = false
    @State private var player: AVAudioPlayer?

    let moods = [
        "Neşeli", "Umutlu", "Çalışkan", "Tembel",
        "Huzurlu", "Hoşlantılı", "İyi", "Üzgün",
        "Yalnız", "Yorgun"
    ]

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                Image("homepage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()


                ScrollView {
                    VStack(spacing: 20) {
                        Text("Studio Ghibli Weather")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        TextField("Şehrini gir", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 24)

                        Text("Bugün nasıl hissediyorsun?")
                            .font(.headline)
                            .foregroundColor(.white)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                            ForEach(moods, id: \.self) { moodName in
                                NavigationLink(destination: MoodDetailView(mood: moodName)) {
                                    Text(moodName)
                                        .padding(8)
                                        .background(Color.white.opacity(0.2))
                                        .cornerRadius(8)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal)

                        Button("Bakalım hava durumu neymiş?") {
                            UIApplication.shared.endEditing()
                            weatherManager.fetchWeather(for: city) { data in
                                self.weather = data
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                        
                        NavigationLink("🎬 Film Önerisi", destination: WeeklyFilmView())
                        NavigationLink("🎧 Ghibli Study Music", destination: GhibliMusicView())
                        
                        if let weather = weather {
                            Text(weather.name)
                                .font(.title2)
                                .foregroundColor(.white)

                            Text("\(Int(weather.main.temp))°C - \(weather.weather.first?.description.capitalized ?? "")")
                                .italic()
                                .foregroundColor(.white)
                        }

                        Spacer().frame(height: 40)
                    }
                    .padding(.vertical)
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer().frame(width: 20) // slight right shift
                                Button(action: {
                                    print("🎵 Müzik butonuna basıldı")
                                    toggleMusic()
                                }) {
                                    Image(systemName: isMusicPlaying ? "speaker.wave.2.fill" : "speaker.slash.fill")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.3))
                                        .clipShape(Circle())
                                        .zIndex(1)
                                }
                                Spacer()
                            }
                            Spacer().frame(height: 1) // push further down
                        }
                    )
                }
            }
        }
    }

    // 🎵 Müzik kontrolü
    func toggleMusic() {
        if isMusicPlaying {
            print("🔇 Müzik durduruluyor")
            player?.stop()
        } else {
            if let url = Bundle.main.url(forResource: "ghibli-style-2-229070", withExtension: "mp3") {
                print("🎵 Müzik dosyası bulundu: \(url)")
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.prepareToPlay()
                    player?.numberOfLoops = -1
                    player?.play()
                    print("🎶 Müzik çalmaya başladı")
                } catch {
                    print("🚫 Müzik çalma hatası: \(error.localizedDescription)")
                }
            } else {
                print("❌ Müzik dosyası bulunamadı.")
            }
        }
        isMusicPlaying.toggle()
    }

    func getGhibliWeatherImage(for condition: String) -> String {
        switch condition {
        case "Clear": return "aksam1"
        case "Rain": return "rainyleaf"
        case "Clouds": return "kikiguzelhava"
        case "Snow": return "snowytotoro"
        default: return "homepage"
        }
    }
}

// Klavyeyi kapatma helper
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
