//
//  funFactPage.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 30/09/2025.
//

import SwiftUI

struct funFactPage: View {
    
    @EnvironmentObject var state: AppState
    @State var currentFact: String = "0"
    var theFact: String {
        factOfToday(for: state.interests)
    }
    
    var body: some View {
        ZStack {
            Color(.factOrange).ignoresSafeArea()

            VStack {
                Spacer()

                HStack {
                    NavigationLink(destination: profilePage()) {
                        Image("\(state.avatar)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }

                    Text("Hello, \(state.name)")
                        .foregroundStyle(.factBeige)
                        .font(.system(size: 21, weight: .bold))


                    Spacer()

                    Rectangle()
                        .fill(Color(.factBeige))
                        .frame(width: 75, height: 30)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .overlay {
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(state.coins)")
                            }
                        }
                }
                .padding(.horizontal)

                ZStack {
                    Rectangle()
                        .fill(Color(.factBeige))
                        .frame(width: 400, height: 680)
                        .cornerRadius(40)

                    VStack(spacing: 20) {
                        HStack(spacing: 5) {
                            Image("lamp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Today’s Fun Fact")
                                .foregroundStyle(.factOrange)
                                .font(.system(size: 21, weight: .bold))

                        }

                        Rectangle()
                            .fill(Color(.factBeige))
                            .frame(width: 315, height: 200)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .overlay {
                                Text(theFact)
                                    .font(.system(size: 21, weight: .regular))
                                    .padding(.horizontal)
                            }

                        HStack {

                            ShareLink(item: currentFact) {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color(.factGreen))

                                Text("Share to get more coins")
                                    .foregroundStyle(.factGreen)
                                    .font(.system(size: 18, weight: .bold))

                            }
                            
                            .simultaneousGesture(TapGesture().onEnded {
                                state.coins += 1
                                UserDefaults.standard.set(state.coins, forKey: "coins")
                            })

                            }


                    }
                }
            }
            .ignoresSafeArea(edges: .all)
        }
    }
}




#Preview {
    NavigationStack {
        funFactPage()
            .environmentObject(AppState())
    }
}
