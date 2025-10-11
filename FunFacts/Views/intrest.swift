import SwiftUI

// MARK: - Model
struct InterestItem: Identifiable {
    let id = UUID()
    let name: String
    let assetName: String
}

// MARK: - Interest Button
struct InterestButton: View {
    let item: InterestItem
    @Binding var selectedInterest: InterestItem?
    let onChosen: () -> Void

    var isSelected: Bool { selectedInterest?.id == item.id }
    var backgroundColor: Color { isSelected ? Color.factOrange.opacity(0.7) : Color.factOrange }

    var body: some View {
        Button {
            if isSelected {
                selectedInterest = nil
            } else {
                selectedInterest = item
            }
            onChosen()
        } label: {
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(backgroundColor)
                    .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    .overlay {
                        HStack(spacing: 20) {
                            Image(item.assetName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)

                            Text(item.name)
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical, 12)
                    }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Interest Selection View
struct InterestSelectionView: View {
    @EnvironmentObject var state: AppState
    @State private var selectedInterest: InterestItem? = nil
    @State private var goNext = false

    private let interests = [
        InterestItem(name: "Random", assetName: "Random"),
        InterestItem(name: "Human", assetName: "Human"),
        InterestItem(name: "Nature", assetName: "Nature"),
        InterestItem(name: "Lifestyle", assetName: "Lifestyle")
    ]

    private var selectionCountText: String {
        let count = selectedInterest == nil ? 0 : 1
        return "(\(count)/1)"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.factBeige.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Hi \(state.name) 👋")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 56)
                        .padding(.horizontal)

                    HStack(spacing: 5) {
                        Text("Choose your interest")
                            .font(.title3)
                            .padding(.horizontal)

                        Text(selectionCountText)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.factOrange)
                    }
                    .padding(.bottom, 30)

                    VStack(spacing: 15) {
                        ForEach(interests) { item in
                            InterestButton(item: item, selectedInterest: $selectedInterest) {
                                let key: String
                                switch item.name {
                                case "Random":     key = "Random"
                                case "Human":      key = "Human"
                                case "Nature":     key = "Nature"
                                case "Lifestyle":  key = "Lifestyle"
                                default:           key = "Random"
                                }

                                state.interests = key
                                UserDefaults.standard.set(key, forKey: "interests")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    goNext = true
                                }
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .navigationDestination(isPresented: $goNext) {
                funFactPage()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Preview
#Preview {
    InterestSelectionView()
        .environmentObject(AppState())
}
