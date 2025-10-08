//
//  profilePage.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 30/09/2025.
//

import SwiftUI

// MARK: - View
struct profilePage: View {

    @EnvironmentObject var state: AppState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.factOrange)
                .ignoresSafeArea(.all)

            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(.factBeige))
                    .frame(width: 400, height: 600)
                    .cornerRadius(40)
            }
            .ignoresSafeArea()

            VStack {
                ZStack {
                    Image(state.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)

                    VStack {
                        Spacer()
                            .frame(height: 180)
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
                }

                Spacer()
                    .frame(height: 400)
            }

            VStack {
                Text("Hello \(state.name)")
                    .font(.largeTitle)
                    .bold()

                Rectangle()
                    .fill(Color(.factBeige))
                    .frame(width: 145, height: 35)
                    .cornerRadius(15)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.factBlack, lineWidth: 1)

                            HStack {
                                Circle()
                                    .fill(Color(.saveButton))
                                    .frame(width: 25, height: 25)
                                    .overlay {
                                        Image(state.interests)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                    }

                                Text(state.interests)
                            }
                        }
                    )
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // MARK: Toolbar
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.factOrange)
                        .font(.headline)
                        .foregroundColor(Color("factBeige"))
                }
            }

            ToolbarItem(placement: .principal) {
                HStack {
                    Spacer(minLength: 240)
                    NavigationLink(destination: EditChildProfileView()) {
                        HStack {
                            Text("Edit")
                                .font(.headline)
                                .foregroundColor(Color("factBeige"))
                            
                            Image(systemName: "pencil")
                                .foregroundStyle(Color(.factBeige))
                                .bold()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        profilePage()
            .environmentObject(AppState())
    }
}
