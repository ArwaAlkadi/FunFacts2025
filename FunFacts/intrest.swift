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
    @State private var isActive = false

    var isSelected: Bool {
        selectedInterest?.id == item.id
    }
    

    var backgroundColor: Color {

        isSelected ? Color.factOrange.opacity(0.7) : Color.factOrange
    }

    var body: some View {
      
            NavigationStack {
                           Button(action: {
                               DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                   isActive = true
                               }
                               
                               if isSelected {
                                   selectedInterest = nil
                               } else {
                                   selectedInterest = item // Select new interest
                               }
                           }) {
                               HStack(spacing: 20) {
                                  
                                   
                                   RoundedRectangle(cornerRadius: 15)
                                       .frame(maxWidth: .infinity)
                                       .foregroundStyle(backgroundColor) // This uses the computed property above
                                       .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                                       .overlay() {
                                           HStack(spacing: 20) {
                                               Image(item.assetName)
                                                   .resizable()
                                                   .scaledToFit()
                                                   .frame(width: 60, height: 60)
                                               
                                               Text(item.name)
                                                   .font(.largeTitle)
                                                   .fontWeight(.medium)
                                                   .foregroundStyle(Color.white)
                                           }
                                       }
                               }
                           }
                           
                           .navigationDestination(isPresented: $isActive) {
                               funFactPage()
                           }
                     
            
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
                    .padding(.horizontal)
                HStack(spacing: 5) {
                    Text("Choose your interest")
                        .font(.title3)
                        .foregroundColor(.factBlack)
                        .padding(.horizontal)
                    
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
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        InterestSelectionView()
            .environmentObject(AppState())
    }
}
