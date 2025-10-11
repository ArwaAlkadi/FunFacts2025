//
//  EditChildProfileView.swift
//  The Launch proj
//
//  Created by Najd Alsabi on 03/04/1447 AH.
//
//  EditChildProfileView.swift

import SwiftUI

// MARK: - Models

enum Interest: String, CaseIterable, Identifiable {
    case random = "Random"
    case human = "Human"
    case nature = "Nature"
    case lifestyle = "Lifestyle"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .random:   return "Random"
        case .human:    return "Human"
        case .nature:   return "Nature"
        case .lifestyle:return "Lifestyle"
        }
    }

    var color: Color {
        switch self {
        case .random:   return .orange
        case .human:    return .purple
        case .nature:   return .green
        case .lifestyle:return .pink
        }
    }

    var stateKey: String {
        switch self {
        case .random:   return "Random"
        case .human:    return "Human"
        case .nature:   return "Nature"
        case .lifestyle:return "Lifestyle"
        }
    }

    static func from(stateString: String) -> Interest {
        switch stateString {
        case "Random":   return .random
        case "Human":    return .human
        case "Nature":   return .nature
        case "Lifestyle":return .lifestyle
        default:         return .random
        }
    }
}

struct Avatar: Identifiable, Hashable {
    let id = UUID()
    let assetName: String
    let cost: Int
}

struct ChildProfile: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var interest: Interest
    var avatar: Avatar
}

// MARK: - Sample Data

private let allAvatars: [Avatar] = [
    Avatar(assetName: "avatarCamel", cost: 0),
    Avatar(assetName: "avatarCat", cost: 0),
    Avatar(assetName: "avatarDeer", cost: 5),
    Avatar(assetName: "avatarDuck", cost: 10),
    Avatar(assetName: "avatarEagle", cost: 15),
    Avatar(assetName: "avatarFish", cost: 20),
    Avatar(assetName: "avatarFox", cost: 25),
    Avatar(assetName: "avatarFrog", cost: 30),
    Avatar(assetName: "avatarGiraffe", cost: 35),
    Avatar(assetName: "avatarKoala", cost: 40),
    Avatar(assetName: "avatarLion", cost: 45),
    Avatar(assetName: "avatarLlama", cost: 50),
    Avatar(assetName: "avatarOwl", cost: 55),
    Avatar(assetName: "avatarPanda", cost: 60),
    Avatar(assetName: "avatarRabbit", cost: 65),
    Avatar(assetName: "avatarTiger", cost: 70),
]

// MARK: - Edit Page

struct EditChildProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var state: AppState

    @State private var profile: ChildProfile?
    @State private var coinBalance: Int = 0
    @State private var nameText: String = ""
    @State private var showAvatarPicker = false
    @State private var showInterestList = false

    @State private var originalName: String = ""
    @State private var originalInterest: Interest = .random

    var body: some View {
        ZStack {
            Color("factOrange").ignoresSafeArea()

            if let profile {
                VStack(spacing: 60) {
                    header(profile: profile)
                        .zIndex(1)
                        .padding(.top, 220)

                    VStack(spacing: 90) {
                        form(
                            profileBinding: Binding(
                                get: { profile },
                                set: { self.profile = $0 }
                            )
                        )
                        saveButton(profile: profile)
                    }
                    .padding(50)
                    .padding(.top, 50)
                    .padding(.bottom, 115)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color("factBeige"))
                    )
                    .offset(y: -140)
                }
            } else {
                ProgressView()
                    .onAppear(perform: bootstrapFromState)
            }
        }
        .sheet(isPresented: $showAvatarPicker) {
            if let profile {
                AvatarPickerSheet(
                    selected: Binding(
                        get: { profile.avatar },
                        set: { self.profile?.avatar = $0 }
                    ),
                    balance: $coinBalance
                )
                .environmentObject(state)
                .presentationDetents([.fraction(0.45), .large])
                .presentationDragIndicator(.visible)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
                    .foregroundColor(Color("factBeige"))
            }
        }
    }

    private var hasChanges: Bool {
        guard let profile else { return false }
        return nameText.trimmingCharacters(in: .whitespaces) != originalName
            || profile.interest != originalInterest
            || profile.avatar.assetName != state.avatar
    }

    private func bootstrapFromState() {
        let interest = Interest.from(stateString: state.interests)
        let currentAvatar = allAvatars.first(where: { $0.assetName == state.avatar }) ?? allAvatars.first!
        let p = ChildProfile(name: state.name, interest: interest, avatar: currentAvatar)

        self.profile = p
        self.coinBalance = state.coins
        self.nameText = state.name
        self.originalName = state.name
        self.originalInterest = interest
    }

    private func header(profile: ChildProfile) -> some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Image(profile.avatar.assetName)
                            .resizable()
                            .scaledToFill()
                    )

                Button {
                    showAvatarPicker = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color("factOrange"))
                        .padding(10)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
                }
                .offset(x: -30, y: -12)
            }

            HStack(spacing: 1) {
                Image("coins")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

                Text("\(coinBalance)")
                    .font(.subheadline.weight(.medium))
                    .padding(.top, 2)
            }
        }
        .padding(.top, 40)
    }

    private func form(profileBinding: Binding<ChildProfile>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name")
                .font(.headline)

            TextField("Enter name", text: $nameText)
                .textInputAutocapitalization(.words)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text("Interest")
                    .font(.headline)

                Button {
                    withAnimation { showInterestList.toggle() }
                } label: {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(profileBinding.wrappedValue.interest.color)
                                .frame(width: 28, height: 28)

                            Image(profileBinding.wrappedValue.interest.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }

                        Text(profileBinding.wrappedValue.interest.rawValue)
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: showInterestList ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }

                if showInterestList {
                    VStack(spacing: 8) {
                        ForEach(Interest.allCases) { item in
                            Button {
                                var p = profileBinding.wrappedValue
                                p.interest = item
                                profileBinding.wrappedValue = p
                                showInterestList = false
                            } label: {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(item.color)
                                            .frame(width: 28, height: 28)

                                        Image(item.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                    }

                                    Text(item.rawValue)
                                        .foregroundColor(.white)

                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(item.color)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .padding(.top, 6)
    }

    private func saveButton(profile: ChildProfile) -> some View {
        Button {
            let chosen = profile.avatar
            let avatarChanged = (state.avatar != chosen.assetName)

            var newBalance = coinBalance
            if avatarChanged && chosen.cost > 0 && chosen.assetName != state.avatar {
                newBalance = max(0, coinBalance - chosen.cost)
            }

            state.name = nameText.trimmingCharacters(in: .whitespaces)
            state.interests = profile.interest.stateKey
            state.avatar = chosen.assetName
            state.coins = newBalance

            UserDefaults.standard.set(state.name, forKey: "name")
            UserDefaults.standard.set(state.interests, forKey: "interests")
            UserDefaults.standard.set(state.avatar, forKey: "avatar")
            UserDefaults.standard.set(state.coins, forKey: "coins")
            
            scheduleDailyFunFact(name: state.name,
                                         interests: state.interests,
                                         atHour: 16,
                                         minute: 0)

            dismiss()
        } label: {
            Text("Save")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(hasChanges ? Color("factGreen") : Color(.systemGray4))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
        }
        .disabled(!hasChanges)
        .padding(.top, 8)
    }
}

// MARK: - Avatar Picker Sheet

struct AvatarPickerSheet: View {
    @Binding var selected: Avatar
    @Binding var balance: Int

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var state: AppState

    private let avatars = allAvatars
    @State private var tempSelection: Avatar? = nil
    @State private var showInsufficientAlert = false

    private var ctaTitle: String {
        let chosen = tempSelection ?? selected
        let isOwned = state.ownedAvatars.contains(chosen.assetName) || chosen.cost == 0
        return isOwned ? "Use Avatar" : "Unlock  (\(chosen.cost) Coins)"
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {

                HStack {
                    Text("Pick your avatar")
                        .font(.headline)

                    Spacer()

                    Text("\(balance)")
                        .font(.subheadline.weight(.bold))
                        
                    Image("coins")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(10)

                let columns = [GridItem(.adaptive(minimum: 110), spacing: 10)]
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(avatars) { avatar in
                            avatarButton(avatar)
                        }
                    }
                    .padding(.vertical, 4)
                }

                HStack {
                    Button("Cancel") { dismiss() }
                        .padding(.leading, 10)
                        .foregroundColor(Color("factOrange"))

                    Spacer()

                    Button {
                        let chosen = tempSelection ?? selected
                        let isOwned = state.ownedAvatars.contains(chosen.assetName) || chosen.cost == 0

                        if !isOwned {
                            if chosen.cost == 0 {
                                state.ownedAvatars.insert(chosen.assetName)
                                state.saveOwnedAvatars()
                            } else if balance >= chosen.cost {
                                balance = max(0, balance - chosen.cost)
                                state.coins = balance
                                state.ownedAvatars.insert(chosen.assetName)
                                state.saveOwnedAvatars()
                                UserDefaults.standard.set(state.coins, forKey: "coins")
                            } else {
                                showInsufficientAlert = true
                                return
                            }
                        }

                        selected = chosen
                        dismiss()
                    } label: {
                        HStack(spacing: 2) {
                            if state.ownedAvatars.contains((tempSelection ?? selected).assetName)
                                || (tempSelection ?? selected).cost == 0 {
                                Text("Use Avatar")
                                    .font(.headline)
                            } else {
                                Text("Unlock    ")
                                    .font(.headline)

                                Image("coins")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)

                                Text("\((tempSelection ?? selected).cost)")
                                    .font(.headline)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(Color("factOrange"))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                    }
                }
            }
            .padding(16)
            .onAppear { tempSelection = selected }
            .alert("Not enough coins", isPresented: $showInsufficientAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You don’t have enough coins to unlock this avatar.")
            }
        }
    }

    @ViewBuilder
    private func avatarButton(_ avatar: Avatar) -> some View {
        let owned = state.ownedAvatars.contains(avatar.assetName) || avatar.cost == 0

        Button {
            tempSelection = avatar
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    Image(avatar.assetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .opacity(owned ? 1 : 0.55)

                    Circle()
                        .stroke(
                            avatar == (tempSelection ?? selected)
                                ? Color.primary.opacity(0.7)
                                : Color.clear,
                            lineWidth: 1
                        )
                        .frame(width: 100, height: 100)

                    if !owned {
                        ZStack {
                            Circle().fill(Color.black.opacity(0.35))
                            Image(systemName: "lock.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100)
                    }
                }

                if avatar.cost == 0 {
                    Text("Free")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                } else {
                    HStack(spacing: 4) {
                        Text("\(avatar.cost)")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)

                        Image("coins")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EditChildProfileView()
            .environmentObject(AppState())
    }
}
