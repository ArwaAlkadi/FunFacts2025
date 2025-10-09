//
//  RootView.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI

// MARK: - RootView
struct RootView: View {
    @EnvironmentObject var state: AppState
    @State private var showSplash = true
    @State private var splashOpacity = 1.0
    @State private var openedFromNotification = false

    var body: some View {
        if showSplash {
            Splashpage()
                .opacity(splashOpacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeOut(duration: 0.9)) {
                            splashOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            showSplash = false
                            openedFromNotification = UserDefaults.standard.bool(forKey: "openedFromNotification")
                        }
                    }
                }
        } else {
            if openedFromNotification {
                funFactPage()
            } else if !state.didOnboard {
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

// MARK: - Preview
#Preview {
    RootView()
        .environmentObject(AppState())
}
