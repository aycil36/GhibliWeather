import SwiftUI
import AVKit

struct MoodDetailView: View {
    let mood: String
    
    enum MediaItem {
        case image(name: String)
        case video(name: String)
    }

    struct MoodMedia {
        let files: [MediaItem]
    }
    // 💡 En üste ekle:

    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("Senin için bir sahne seçtik:")
                        .font(.title2)
                        .foregroundColor(.white)

                    // MEDYA GÖSTERİMİ
                    if let currentMedia = moodMedia[mood]?.files[currentIndex] {
                        if case .image(let name) = currentMedia {
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(16)
                        } else if case .video(let name) = currentMedia {
                            if let url = Bundle.main.url(forResource: name, withExtension: "mp4") {
                                VideoPlayer(player: AVPlayer(url: url))
                                    .frame(height: 300)
                                    .cornerRadius(16)
                            } else {
                                        Text("Video bulunamadı")
                                            .foregroundColor(.red)
                            }
                        }
                    }

                    // MESAJ
                    Text(getMoodMessage(for: mood))
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    // İLERİ / GERİ BUTONLARI
                    HStack {
                        Button("← Geri") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)

                        Spacer()

                        Button("İleri →") {
                            if let count = moodMedia[mood]?.files.count, currentIndex < count - 1 {
                                currentIndex += 1
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle(mood)
    }

    func getMoodMessage(for mood: String) -> String {
        switch mood {
        case "Neşeli": return "Neşen bulaşıcı. Bugün senin günün!"
        case "Umutlu": return "Umut, en zor günlerde bile yolumuzu aydınlatır."
        case "Çalışkan": return "Bugün gösterdiğin emek, yarının başarısı olacak."
        case "Tembel": return "Bazen yavaşlamak da bir ilerleme biçimidir."
        case "Huzurlu": return "İçindeki sessizlik en güzel melodidir."
        case "Hoşlantılı": return "Kalp çarpıntısı, hayattasın demenin başka bir yolu."
        case "İyi": return "Kendini iyi hissetmen, her şeyin yolunda olduğunu gösterir."
        case "Üzgün": return "Her fırtına diner. Bugün geçecek."
        case "Yalnız": return "Kendinle vakit geçirmek de bir sanattır."
        case "Umutsuz": return "Karanlık anlar bile yeni ışıkların habercisidir."
        case "Yorgun": return "Dinlenmek, yeniden başlamak için gereklidir."
        default: return ""
        }
    }
}

let moodMedia: [String: MoodMedia] = [
    "Neşeli": MoodMedia(files: [
        .image(name: "neselen"),
        .video(name: "goodmorningif"),
        .image(name: "tototoro")
    ]),
    "Umutlu": MoodMedia(files: [
        .image(name: "sunnystudent"),
        .video(name: "sunnylove")
    ]),
    "Çalışkan": MoodMedia(files: [
        .image(name: "working"),
        .image(name: "workingalone")
    ]),
    "Tembel": MoodMedia(files: [
        .image(name: "tototoro")
    ]),
    "Huzurlu": MoodMedia(files: [
        .image(name: "totosirin"),
        .video(name: "rainyy")
    ]),
    "Hoşlantılı": MoodMedia(files: [
        .image(name: "sunnystudent"),
        .video(name: "sunnylove"),
        .image(name: "acikaksam")
    ]),
    "İyi":  MoodMedia(files: [
        .image(name: "sunnydaykiki"),
        .image(name: "sunnylay")
    ]),
    "Üzgün":  MoodMedia(files: [
        .image(name: "saddy")
    ]),
    "yalnız":  MoodMedia(files: [
        .image(name: "saddy")
    ]),
    "Yorgun":  MoodMedia(files: [
        .image(name: "uzanmali"),
        .video(name: "calmday")
    ])
]
