import SwiftUI

struct WeeklyFilmView: View {
    struct Film {
        let name: String
        let description: String
        let image: String
    }

    let films: [Film] = [
        Film(name: "Spirited Away", description: "Chihiro'nun büyülü dünyadaki yolculuğu.", image: "spirited"),
        Film(name: "My Neighbor Totoro", description: "İki kız kardeşin Totoro ile tanışması.", image: "totoro"),
        Film(name: "Kiki’s Delivery Service", description: "Genç bir cadının bağımsızlık yolculuğu.", image: "kiki")
    ]

    var currentFilm: Film {
        let week = Calendar.current.component(.weekOfYear, from: Date())
        return films[week % films.count]
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Bu Haftanın Ghibli Filmi")
                .font(.title)
                .bold()

            Image(currentFilm.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .padding()

            Text(currentFilm.name)
                .font(.title2)

            Text(currentFilm.description)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}
