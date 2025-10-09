
# FunFacts  
FunFacts is a simple and interactive iOS app that delivers a fun daily fact based on the user’s selected interest.
Customize your profile, collect coins, and enjoy learning something new every day — with daily notifications that deliver your fun fact directly to you!

##  Features  
- **Personalized Experience**  
  Enter your name and choose your favorite interest category.  
- **Interactive Profile**  
  View your avatar, name, interests, and collected coins.  
- **Coin System**  
  Earn coins by sharing facts or unlocking new avatars.  
-  **Daily Notifications**  
  Receive one fun fact notification every day at your chosen time.  
- **Modern SwiftUI Design**  
  Clean, colorful, and responsive interface.  

## Requirements  
- iOS 17.0 or later  
- Xcode 15 or later  
- Swift 5.9  
- SwiftUI framework  

## Setup  
1. Open the project in **Xcode**.  
2. Set the deployment target to **iOS 17.0**.  
3. Run the app on a simulator or real device.  
4. Complete onboarding and enjoy your daily fact!  

## Notifications  
The app uses **UNUserNotificationCenter** to send one daily fun fact.  
You can edit the notification time inside **Notifications.swift**:  

```swift
var time = DateComponents()
time.hour = 20
time.minute = 0
```

## Data Persistence
All user data (name, avatar, interests, coins, onboarding status) is stored using UserDefaults.

## Concept
FunFacts encourages users to learn something new every day — quickly, easily, and enjoyably.

## Developers
- Arwa Alkadi
- Najd Alsabi
- Asma Alqahtani
- Samar Alqahtani
- Ghaida AlMughamer

README.md
