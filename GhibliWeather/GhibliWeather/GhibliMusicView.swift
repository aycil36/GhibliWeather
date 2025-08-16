import SwiftUI

struct GhibliMusicView: View {
    let playlists = [
        ("Rainy Day Ghibli", "https://www.youtube.com/embed/WQYnU7cV0xE"),
        ("LoFi Chill Ghibli", "https://www.youtube.com/embed/akH7Adg_5fs")
    ]

    var body: some View {
        List(playlists, id: \.0) { (title, urlStr) in
            NavigationLink(title) {
                if let url = URL(string: urlStr) {
                    WebView(url: url)
                        .navigationTitle(title)
                }
            }
        }
        .navigationTitle("Ghibli Playlist")
    }
}
