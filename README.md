# FlowerFresh

FlowerFresh is a SwiftUI-based iOS application that showcases a flower shop interface, allowing users to browse a grid of flowers, view details, favorite flowers locally, and initiate a checkout process. The app demonstrates modern iOS development practices, including MVVM architecture, integration with Firebase Firestore or a mock REST API, and local persistence using `UserDefaults`. This project highlights my skills in SwiftUI, networking, and clean architecture design.

## Features
- **Dynamic Flower Grid**: Displays a two-column grid of flowers with name, price, availability, and favorite status, fetched from Firebase Firestore or a mock API.
- **Interactive UI**: Smooth tap animations on flower cards using spring-based scaling.
- **Detail View**: Navigation to a detailed view for each flower, showing a larger image, price, availability, and options to favorite or checkout.
- **Local Favorites**: Favorite status is stored locally using `UserDefaults`, ensuring persistence across app sessions without backend storage.
- **MVVM Architecture**: Clean separation of concerns with Model (data), View (UI), ViewModel (business logic), and Service (networking).
- **Dual Data Sources**: Supports fetching flower data from Firebase Firestore (real-time) or a mock REST API (via Mockoon) using a protocol-based service layer.
- **Error Handling**: Displays loading states and error messages for network or Firestore failures.
- **Responsive Design**: Adapts to light and dark modes with a native iOS look using system colors.

## Screenshots
| Flower Grid | Flower Detail |
|-------------|---------------|
| ![Grid View](https://github.com/FlowerFresh/screenshots/grid_view.png) | ![Detail View](https://github.com/FlowerFresh/screenshots/detail_view.png) |

## Technologies Used
- **SwiftUI**: For building a modern, declarative UI.
- **MVVM Architecture**: For clean, testable, and maintainable code.
- **Combine**: For reactive data fetching and state updates.
- **Firebase Firestore**: For real-time data fetching (optional data source).
- **Mockoon**: For mock REST API integration (alternative data source).
- **UserDefaults**: For local persistence of favorite flowers.
- **Xcode 15.6+**: Development environment targeting iOS 15.0+.

## Project Structure
```
FlowerFresh/
├── FlowerFresh  # Main SwiftUI views, ViewModel, and services
├── FlowerFresh/Resources/Assets.xcassets/ # Flower images (rose, tulip, lily, etc.)
├── FlowerFresh/Configurations/GoogleService-Info.plist # Firebase configuration (for Firestore)
└── README.md # Project documentation
```

- **Model**: `Flower` struct defines the data model (`id`, `name`, `imageName`, `price`, `availability`).
- **ViewModel**: `FlowerViewModel` manages UI state (`flowers`, `isLoading`, `errorMessage`) and business logic (fetching data, toggling favorites).
- **Views**: `FlowerGridView`, `FlowerCardView`, and `FlowerDetailView` handle UI rendering and user interactions.
- **Services**: `FlowerService` protocol with `NetworkService` (Mockoon API) and `FirestoreService` (Firebase) implementations.

## Setup Instructions
### Prerequisites
- **Xcode**: Version 15.6 or later.
- **iOS**: 15.0 or later.
- **Firebase Account**: For Firestore integration (optional).
- **Mockoon**: For mock API testing (optional).
- **CocoaPods**: For Firebase dependencies (if using Firestore).

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/FlowerFresh.git
   cd FlowerFresh
   ```

2. **Firebase Setup (Optional)**:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
   - Add an iOS app with your bundle ID (e.g., `com.example.FlowerFresh`).
   - Download `GoogleService-Info.plist` and add it to the project root in Xcode.
   - Install Firebase dependencies via CocoaPods:
     ```bash
     pod install
     ```
     Podfile:
     ```ruby
     platform :ios, '15.0'
     target 'FlowerFresh' do
       use_frameworks!
       pod 'FirebaseCore', '~> 11.0'
       pod 'FirebaseFirestore', '~> 11.0'
       pod 'FirebaseFirestoreSwift', '~> 11.0'
     end
     post_install do |installer|
       installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
           config.build_settings['OTHER_CFLAGS'] = config.build_settings['OTHER_CFLAGS'].to_s.gsub('-G', '')
         end
       end
     end
     ```
   - Create a `flowers` collection in Firestore with documents like:
     ```json
     {
       "id": "rose123",
       "name": "Rose",
       "imageName": "rose",
       "price": 5.99,
       "availability": 100
     }
     ```
   - Set permissive Firestore rules for testing:
     ```plaintext
     rules_version = '2';
     service cloud.firestore {
       match /databases/{database}/documents {
         match /{document=**} {
           allow read, write: if true;
         }
       }
     }
     ```

3. **Mock API Setup (Optional)**:
   - Install [Mockoon](https://mockoon.com) and create a `GET /flowers` endpoint with:
     ```json
     [
       {
         "id": "rose123",
         "name": "Rose",
         "imageName": "rose",
         "price": 5.99,
         "availability": 100
       },
       {
         "id": "tulip456",
         "name": "Tulip",
         "imageName": "tulip",
         "price": 3.99,
         "availability": 150
       },
       {
         "id": "lily789",
         "name": "Lily",
         "imageName": "lily",
         "price": 4.99,
         "availability": 80
       }
     ]
     ```
   - Start the Mockoon server at `http://localhost:3000`.

4. **Image Assets**:
   - Add images (e.g., `rose`, `tulip`, `lily`) to `Assets.xcassets` in Xcode, matching `imageName` in the data source.
   - For remote images, install `SDWebImageSwiftUI` via SPM (`https://github.com/SDWebImage/SDWebImageSwiftUI`) and update `imageName` to URLs (e.g., `https://example.com/images/rose.jpg`).

5. **Run the App**:
   - Open `FlowerFresh.xcworkspace` (if using CocoaPods) or `FlowerFresh.xcodeproj` (if using SPM).
   - Switch the data source in `FlowerShopApp`:
     - For Mockoon: `FlowerViewModel(service: NetworkService())`
     - For Firestore: `FlowerViewModel(service: FirestoreService())`
   - Build and run on a simulator (iOS 15.6+) or device.

### Usage
- **Browse Flowers**: View a grid of flowers fetched from Firestore or the mock API.
- **Favorite Flowers**: Tap the favorite button in the detail view to toggle favorite status, stored locally in `UserDefaults`.
- **Checkout**: Placeholder button (logs to console) for future implementation.
- **Real-Time Updates**: Firestore provides real-time data syncing; refresh manually for the mock API.

## Future Improvements
- Add user authentication to associate favorites with user accounts.
- Implement a full checkout flow with payment integration.
- Support remote images via Firebase Storage or a CDN.
- Add unit tests for `FlowerViewModel` and services.
- Enhance error handling with user-friendly alerts.

## Contributing
Contributions are welcome! Please:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License
This project is licensed under the MIT License. See the [https://github.com/FlowerFresh/LICENSE.txt](LICENSE) file for details.

## Contact
- **Author**: Saba Anwar
- **GitHub**: https://github.com/sabaanwar411
- **Email**: sabaanwar411@gmail.com
