import Foundation

enum MediaItem {
    case image(name: String)
    case video(name: String)
}

struct MoodMedia {
    let files: [MediaItem]
}
