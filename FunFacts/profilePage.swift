//
//  profilePage.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 30/09/2025.
//

//اضيفي الداتا للصفحة هذي وعدلي البريفيو حقها

import SwiftUI


struct profilePage: View {

    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.factOrange)
                .ignoresSafeArea(.all)

            VStack {
                HStack {

                    Button {
                               dismiss()
                    } label: {
                        Circle()
                              .fill(Color(.factBeige))
                              .frame(width: 40, height: 40)
                              .overlay {
                                  Image(systemName: "arrow.backward")
                                      .foregroundStyle(Color(.factOrange))
                              }
                    }

                    Spacer()
                    
                    NavigationLink(destination: EditChildProfileView()) {
                        HStack {
                            Text("Edit")
                                .foregroundStyle(Color(.factBeige))
                                .bold()

                            Image(systemName: "pencil")
                                .foregroundStyle(Color(.factBeige))
                                .bold()
                        }
                    }

                }
                .padding(20)
                Spacer()
            }

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
                    Image("avatarOwl")
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
                                    Text("0")
                                }
                            }
                    }

                }

                Spacer()
                    .frame(height: 400)
            }

            VStack {
                Text("Hello, Meshael ")
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
                                Image(systemName: "figure.walk")
                                    .font(Font.title2)
                                Text("Human")
                            }
                        }

                    )

            }



        }
        .navigationBarBackButtonHidden(true)
    }
}




#Preview {
    profilePage()
}
