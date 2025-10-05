
import SwiftUI


// MARK: - Component 2: Profile Image and '+' Button (Final Styling)
struct AvatarWithPlusButton: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        // ZStack is used only to contain the avatar and its overlay
        ZStack {
            // Owl Image - now handles its own clipping and shadow
            Image("avatarCamel")
                .resizable()
                .scaledToFill()
                .frame(width: 136, height: 230)
// Clips the image into a circle
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 4) // Shadow applied directly
        }
        // .overlay positions the '+' button to the bottom-LEFT
        .overlay(alignment: .bottomLeading) {
            NavigationLink(destination: ProfileEditView()) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.factOrange)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.factBeige)
                            .shadow(color: .gray.opacity(0.7), radius: 7, x: 2, y: 2)
                    )
            }
            // Offset adjusted to place the button exactly on the edge
            .offset(x: -9, y: -20)
        }
    }
}


// MARK: - Secondary View for the '+' Button Navigation (Edit Profile)
struct ProfileEditView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.factBeige.ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Edit Profile Picture")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.factBlack)
                
                Text("This is the new page you navigated to. Implement your avatar selection/editor here.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.factBlack.opacity(0.8))

                Button("Go Back") {
                    dismiss()
                }
                .padding()
                .background(.factOrange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Edit Avatar")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Main Sign-up Screen View
struct SignupView: View {
    @State private var nameInput: String = ""
    @State private var coinCount: Int = 0
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                // 1. Overall Background
                Color.factBeige
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    
                    // MARK: - Header
                    Spacer().frame(height: 0)
                    
                    Spacer()
                    
                    // MARK: - Avatar
                    AvatarWithPlusButton()
                    
                    // MARK: - Instruction Text
                    Text("Enter your name to get started!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.factBlack)
                        .padding(.top, -3)
                    
                    // MARK: - Name Text Field (Rounded Style)
                    HStack {
                        // Person icon
                        Image(systemName: "person")
                            .foregroundColor(.black)
                        
                        TextField("Enter your name", text: $nameInput)
                            .foregroundColor(.factBlack)
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
                    
                    // MARK: - Save Button
//                    Button(action: {
//                        
//                        state.name = nameInput
//                        UserDefaults.standard.set(nameInput, forKey: "name")
//                        //  Add your save logic here ***
//                        print("Name saved: \(nameInput)")
//                    }) {
//                        Text("Save")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(.factBeige)
//                            .frame(width: 278, height: 48)
//                            .background(
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(.factGreen)
//                                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
//                            )
//                    }
//                    .padding(.bottom, 120)
                    
           NavigationLink(destination: InterestSelectionView()) {
               Text("Save")
                   .font(.title2)
                   .fontWeight(.bold)
                   .foregroundColor(.factBeige)
                   .frame(width: 278, height: 48)
                   .background(
                       RoundedRectangle(cornerRadius: 15)
                           .fill(.factGreen)
                           .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                   )
                    }
                    .padding(.bottom, 120)
                }
            }
            // Hide the NavigationStack bar on the root view
            .navigationBarHidden(true)
            
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
