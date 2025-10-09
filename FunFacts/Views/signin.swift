import SwiftUI

// MARK: - Avatar With Plus Button
struct AvatarWithPlusButton: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack {
            Image(state.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 136, height: 230)
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 4)
        }
    }
}

// MARK: - Signup View
struct SignupView: View {
    @State private var nameInput: String = ""
    @EnvironmentObject var state: AppState
    @State private var goNext = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.factBeige.ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    AvatarWithPlusButton()

                    Text("Enter your name to get started!")
                        .font(.title3)
                        .fontWeight(.medium)

                    HStack {
                        if nameInput.isEmpty {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                        }
                        TextField("Enter your name", text: $nameInput)
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 300)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    )

                    Spacer()

                    Button {
                        state.name = nameInput.trimmingCharacters(in: .whitespacesAndNewlines)
                        UserDefaults.standard.set(state.name, forKey: "name")
                        goNext = true
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.factBeige)
                            .frame(width: 278, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(nameInput.isEmpty ? .gray.opacity(0.4) : .factGreen)
                            )
                    }
                    .disabled(nameInput.isEmpty)
                    .padding(.bottom, 120)
                }
            }
            .navigationDestination(isPresented: $goNext) {
                InterestSelectionView()
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            scheduleDailyFunFact(using: state)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SignupView()
            .environmentObject(AppState())
    }
}
