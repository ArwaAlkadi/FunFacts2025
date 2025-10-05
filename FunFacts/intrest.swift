import SwiftUI


struct InterestItem: Identifiable {
    let id = UUID()
    let name: String
    let assetName: String
}


// MARK: - Component 1: The Clickable Interest Button
struct InterestButton: View {
    let item: InterestItem // Now uses InterestItem
    @Binding var selectedInterest: InterestItem?


    var isSelected: Bool {
        selectedInterest?.id == item.id
    }
    

    var backgroundColor: Color {

        isSelected ? Color.factOrange.opacity(0.7) : Color.factOrange
    }

    var body: some View {
        Button(action: {
            // Logic: Toggle selection.
            if isSelected {
                selectedInterest = nil
            } else {
                selectedInterest = item // Select new interest
            }
        }) {
            HStack(spacing: 20) {
                
                Image(item.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                Text(item.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white) // Text and icon color
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor) // This uses the computed property above
                    .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
            )
        }
        .padding(.horizontal)
    }
}


// MARK: - Main Interest Selection View
struct InterestSelectionView: View {
    
    let userName: String = "Meshael"
    
    
    @State private var selectedInterest: InterestItem? = nil

    
    private let interests = [
        InterestItem(name: "Random", assetName: "Dice"),
        InterestItem(name: "Human", assetName: "Human"),
        InterestItem(name: "Nature", assetName: "leaf"),
        InterestItem(name: "Life Style", assetName: "Lifestyle")
    ]
    
   
    private var selectionCountText: String {
        let count = selectedInterest == nil ? 0 : 1
        return "(\(count)/1)"
    }
    
    var body: some View {
        
        ZStack {
            // Overall Background Color
            Color.factBeige.edgesIgnoringSafeArea(.all)
            
            // MARK: - Content
            VStack(alignment: .leading, spacing: 10) {
                
                // MARK: - Header
                Text("Hi \(userName) 👋")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.factBlack)
                    .padding(.top, 56)
                HStack(spacing: 5) {
                    Text("Choose your interest")
                        .font(.title3)
                        .foregroundColor(.factBlack)
                    
                    Text(selectionCountText) // Dynamic Counter
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.factOrange)
                }
                .padding(.bottom, 30)
                
                // MARK: - Interest Buttons
                VStack(spacing: 15) {
                    ForEach(interests) { item in
                        InterestButton(item: item, selectedInterest: $selectedInterest)
                    }
                }
                
                Spacer() // Pushes content to the top
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
        }
         HStack {
                            Text("Next")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.factGreen)
                                )
                                // Button darkens when disabled
                                .opacity(selectedInterest != nil ? 1.0 : 0.4)
                        }
                        // Only enable the button if an interest is selected
                        .disabled(selectedInterest == nil)
                        .padding(.trailing, 20) // Spacing from the right edge
                        .padding(.bottom, 30)
                   
    }
}

// MARK: - Preview
#Preview {
    InterestSelectionView()
}
