import SwiftUI

enum Mood: String, CaseIterable {
    case neseli = "Neşeli"
    case uzgun = "Üzgün"
    case yorgun = "Yorgun"
    case caliskan = "Çalışkan"
    case iyi = "İyi"

    var imageName: String {
        switch self {
        case .neseli: return "neseliImage"
        case .uzgun: return "uzgunImage"
        case .yorgun: return "yorgunImage"
        case .caliskan: return "caliskanImage"
        case .iyi: return "iyiImage"
        }
    }

    var motivationText: String {
        switch self {
        case .neseli: return "Harika! Enerjini koru."
        case .uzgun: return "Üzülme, güzel günler yakında."
        case .yorgun: return "Biraz dinlenmek iyi gelebilir."
        case .caliskan: return "Çalışkanlık başarı getirir!"
        case .iyi: return "Kendini iyi hissetmen harika!"
        }
    }
}

struct MoodButtonsScrollView: View {
    @Binding var selectedMood: Mood?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Mood.allCases, id: \.self) { mood in
                    MoodButton(mood: mood, selectedMood: $selectedMood)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct MoodButton: View {
    let mood: Mood
    @Binding var selectedMood: Mood?

    var body: some View {
        Button(action: {
            selectedMood = mood
        }) {
            Text(mood.rawValue)
                .font(.system(size: 14, weight: .medium))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    ZStack {
                        Color.white.opacity(selectedMood == mood ? 0.7 : 0.4)
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.8), lineWidth: 1)
                    }
                )
                .foregroundColor(selectedMood == mood ? .black : .white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MoodSceneView: View {
    let mood: Mood

    var body: some View {
        VStack {
            Text("Senin için bir sahne seçtik:")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            Image(mood.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(16)

            Text(mood.motivationText)
                .italic()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
}

