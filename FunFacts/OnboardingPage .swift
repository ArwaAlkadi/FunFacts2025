//
//  OnboardingPage .swift
//  FunFacts
//
//  Created by Asma Alqahtani on 08/04/1447 AH.
//

import SwiftUI

struct OnboardingPageـ {
    let image: String
    let text: String
}

struct OnboardingPage: View {
    
    @State private var currentPage = 0
    @State private var goToSignup = false   // حالة للتنقل
    @EnvironmentObject var state: AppState

    let totalPages = 3
    
   @State var pages: [OnboardingPageـ] = [
        OnboardingPageـ(image: "onboardingpage1",
                       text: "Discover an interesting fact every day in just seconds!"),
        OnboardingPageـ(image: "onboardingpage2",
                       text: "Select your interests to receive facts that matter to you"),
        OnboardingPageـ(image: "onboardingpage3",
                       text: "Get one daily notification quick, useful, and fun to share!")
    ]
    
    var body: some View {
        ZStack {
            Color("factBeige").ignoresSafeArea()
            
            VStack {
                // Skip button
                HStack {
                    Spacer()
                    Button {
                        state.didOnboard = true
                        UserDefaults.standard.set(true, forKey: "didOnboard")
                    } label: {
                        NavigationLink(destination: SignupView()) {
                            Text("Skip")
                                .underline()
                                .foregroundColor(.gray)
                                .padding(.horizontal, 25)
                        }
                    }

                }
                
                //  Swipeable pages
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { i in
                        VStack(spacing: 20) {
                            Image(pages[i].image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                            
                            Text(pages[i].text)
                                .font(.system(size: 21 ,weight:.medium))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // page indicators
                HStack(spacing: 6) {
                    ForEach(0..<totalPages, id: \.self) { i in
                        if i == currentPage {
                            Capsule()
                                .fill(Color("factGreen"))
                                .frame(width: 25, height: 8)
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Next button
                HStack {
                    Spacer()
                    Button {
                        if currentPage < pages.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            goToSignup = true // آخر صفحة يوديه SignupView
                            state.didOnboard = true
                            UserDefaults.standard.set(true, forKey: "didOnboard")
                        }
                    } label: {
                        Image("Arrow")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(18)
                            .background(Circle().fill(Color("factGreen")))
                    }
                    .padding(.horizontal, 25) // keeps arrow away from edge
                }
            }
            
            // Hidden NavigationLink (خارج الـ VStack عشان ما يخرب العناصر)
            .navigationDestination(isPresented: $goToSignup) {
                SignupView()
            }
        }
    }
}


#Preview {
    NavigationStack {
        OnboardingPage()
            .environmentObject(AppState())
    }
}

