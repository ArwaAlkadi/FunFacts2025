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
    
    var body: some View {
       
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
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
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
                withAnimation(.easeInOut(duration: 2.0)) { // مدة تكبير الدائرة أطول
                    circleSize = 2000
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) { // ظهور اللوجو
                    withAnimation(.easeOut(duration: 1.0)) {
                        showLogo = true
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // ظهور السلوغان
                    withAnimation {
                        showSlogan = true
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

