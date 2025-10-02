//
//  OnboardingPage .swift
//  FunFacts
//
//  Created by Asma Alqahtani on 08/04/1447 AH.
//

import SwiftUI

struct OnboardingPage {
    let image: String
    let text: String
}

struct OnboardingPage_: View {
    
    @State private var currentPage = 0
    let totalPages = 3
    
    let pages: [OnboardingPage] = [
        OnboardingPage(image: "onboardingpage1 ",
                       text: "Discover a new fun fact every single day!"),
        OnboardingPage(image: "onboardingpage2",
                       text: "Choose your interests to get facts that matter to you!"),
        OnboardingPage(image: "onboardingpage3",
                       text: "Start your journey with us today!")
    ]
    
    var body: some View {
        ZStack {
            Color("factBeige").ignoresSafeArea()
            
            VStack {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                     
                        currentPage = pages.count - 1
                    }
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 25)
                }
                
                //Spacer()
                
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
                
                // page indicators go HERE
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
                        }
                    } label: {
                        Image("Arrow")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(18)
                            .background(Circle().fill(Color("factGreen")))
                            //.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal, 25) // keeps arrow away from edge
                }
            }
        }
    }
}

#Preview {
    OnboardingPage_()
}
