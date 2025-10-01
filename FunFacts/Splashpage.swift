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
    @State private var goNext = false
    
    var body: some View {
        if goNext {
            ContentView()
        } else {
            ZStack {
                
                Circle()
                    .fill(Color("factOrange"))
                    .frame(width: circleSize, height: circleSize)
                    .ignoresSafeArea()
                
            
                if showLogo {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .transition(.scale.combined(with: .opacity))
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
    Splashpage()
}
