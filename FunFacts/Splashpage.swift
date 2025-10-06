//
//  Splashpage.swift
//  FunFacts
//
//  Created by Samar A on 08/04/1447 AH.
//

import SwiftUI

struct Splashpage: View {
    @State private var circleSize: CGFloat = 0
    @State private var showLogo = false
    @State private var showSlogan = false
    @State private var goNext = false
    
    var body: some View {
        if goNext {
            OnboardingPage_()
        } else {
            ZStack {
                // الدائرة الخلفية
                Circle()
                    .fill(Color(red: 0.98, green: 0.48, blue: 0.35))
                    .frame(width: circleSize, height: circleSize)
                    .offset(y: -circleSize/4)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // اللوجو
                    if showLogo {
                        Image("tree")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 230, height: 230)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    // السلوغان بشكل بسيط واحترافي
                    if showLogo {
                        Text("✦ Learn • Quick • And • Easy ✦")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .opacity(showSlogan ? 1 : 0)
                            .scaleEffect(showSlogan ? 1 : 0.8)
                            .animation(.easeOut(duration: 1), value: showSlogan)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                }
            }
            .onAppear {
                circleSize = 0
                withAnimation(.easeInOut(duration: 1.5)) {
                    circleSize = 2000
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation(.spring()) {
                        showLogo = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation {
                        showSlogan = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation {
                        goNext = true
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        Splashpage()
            .environmentObject(AppState())
    }
}
