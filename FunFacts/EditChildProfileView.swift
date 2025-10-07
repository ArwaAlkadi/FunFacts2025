//
//  EditChildProfileView.swift
//  The Launch proj
//
//  Created by Najd Alsabi on 03/04/1447 AH.
//

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
        case .random: return "Dice"
        case .human: return "Human"
        case .nature: return "leaf"
        case .lifestyle: return "Lifestyle"
        }
    }

    var color: Color {
        switch self {
        case .random: return .orange
        case .human: return .purple
        case .nature: return .green
        case .lifestyle: return .pink
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
    Avatar(assetName: "avatarPanda",  cost: 60),
    Avatar(assetName: "avatarRabbit", cost: 65),
    Avatar(assetName: "avatarTiger", cost: 70),
]

// MARK: - Edit Page

struct EditChildProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var profile: ChildProfile
    @State private var showAvatarPicker = false
    @State private var coinBalance: Int
    @State private var nameText: String
    @State private var showInterestList = false

    // نسخ من البيانات الأصلية لمقارنة التعديلات
    private let originalName: String
    private let originalInterest: Interest

    let onSave: (ChildProfile) -> Void

    init(
        profile: ChildProfile = .init(
            name: "Meshael",
            interest: .nature,
            avatar: allAvatars.first!
        ),
        coinBalance: Int = 18,
        onSave: @escaping (ChildProfile) -> Void = { _ in }
    ) {
        _profile = State(initialValue: profile)
        _coinBalance = State(initialValue: coinBalance)
        _nameText = State(initialValue: profile.name)
        self.originalName = profile.name
        self.originalInterest = profile.interest
        self.onSave = onSave
    }

    // هل صار أي تعديل؟
    private var hasChanges: Bool {
        nameText.trimmingCharacters(in: .whitespaces) != originalName ||
        profile.interest != originalInterest
    }

    var body: some View {
        ZStack {
            Color("factOrange")
                .ignoresSafeArea()

            VStack(spacing: 60){
                header
                    .zIndex(1)
                    .padding(.top, 220)

                VStack(spacing: 90) {
                    form
                    saveButton
                }
                .padding(50)
                .padding(.top,50)
                .padding(.bottom, 115)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color("factBeige"))
                )
                .offset(y: -140)
            }
        }
        .sheet(isPresented: $showAvatarPicker) {
            AvatarPickerSheet(
                selected: $profile.avatar,
                balance: $coinBalance
            )
            .presentationDetents([.fraction(0.45), .large])
            .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color("factBeige"))
            }
        }
    }

    // MARK: Header with avatar
    private var header: some View {
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
                    .font(.subheadline.weight(.medium)).padding(.top, 2)
            }
        }
        .padding(.top, 40)
    }

    // MARK: Form
    private var form: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Name field
            Text("Name")
                .font(.headline)
            TextField("Enter name", text: $nameText)
                .textInputAutocapitalization(.words)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )

            // Interest field
            interestField
        }
        .padding(.top, 6)
    }
    
    // MARK: Custom Dropdown for Interest
    private var interestField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Interest")
                .font(.headline)

            Button {
                withAnimation {
                    showInterestList.toggle()
                }
            } label: {
                HStack {
                    ZStack {
                        Circle()
                            .fill(profile.interest.color)
                            .frame(width: 28, height: 28)
                        Image(profile.interest.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }

                    Text(profile.interest.rawValue)
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
                            profile.interest = item
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

    // MARK: Save
    private var saveButton: some View {
        Button {
            profile.name = nameText
            onSave(profile)
            dismiss()
        } label: {
            Text("Save")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    hasChanges
                    ? Color("factGreen")
                    : Color(.systemGray4)
                )
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

    private let avatars = allAvatars
    @State private var tempSelection: Avatar? = nil

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Pick your avatar")
                    .font(.headline)

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
                        .padding(.leading,10)
                        .foregroundColor(Color("factOrange"))

                    Spacer()

                    Button("Use Avatar") {
                        let chosen = tempSelection ?? selected
                        if chosen.cost > 0 && chosen != selected {
                            balance = max(0, balance - chosen.cost)
                        }
                        selected = chosen
                        dismiss()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color("factOrange"))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 4, y: 2)

                }
            }
            .padding(16)
            .onAppear { tempSelection = selected }
        }
    }

    @ViewBuilder
    private func avatarButton(_ avatar: Avatar) -> some View {
        let enough = balance >= avatar.cost || avatar.cost == 0

        Button {
            guard enough else { return }
            tempSelection = avatar
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    Image(avatar.assetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .opacity(enough ? 1 : 0.5)
                    
                    Circle()
                        .stroke(
                            avatar == (tempSelection ?? selected)
                            ? Color.primary.opacity(0.7)
                            : Color.clear,
                            lineWidth: 1
                        )
                        .frame(width: 100, height: 100)

                    if avatar.cost > 0 && balance < avatar.cost {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.35))
                            Image(systemName: "lock.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100)
                    }
                }

                Text(avatar.cost == 0 ? "Free" : "\(avatar.cost) Coins")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EditChildProfileView(
            profile: ChildProfile(
                name: "Meshael",
                interest: .nature,
                avatar: allAvatars.first!
            ),
            coinBalance: 18
        ) { updated in
            print("Saved:", updated)
        }
    }
}

