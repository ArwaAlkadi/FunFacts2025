//
//  RootView.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var state: AppState
    @State private var showSplash = true
    @State private var splashOpacity = 1.0

    var body: some View {
        if showSplash {
            Splashpage()
                .opacity(splashOpacity)
                .onAppear {
                    // تبقى الشاشة 5 ثواني قبل التلاشي
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation(.easeOut(duration: 0.9)) {
                            splashOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            showSplash = false
                        }
                    }
                }
        } else {
            if !state.didOnboard {
                OnboardingPage()
            } else if state.name.isEmpty {
                SignupView()
            } else if state.interests.isEmpty {
                InterestSelectionView()
            } else {
                funFactPage()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppState())
}
