# Egypt Tourist Guide - Mobile Application

## Project General Description

The **Egypt Tourist Guide** is a mobile application designed to help tourists explore landmarks, museums, and attractions across various Egyptian governorates. The app provides a user-friendly interface for discovering popular places, saving favorites, and managing user profiles. This project aims to enhance the tourism experience by offering curated suggestions and personalization.
it manages state using Bloc (in controllers folder).

# State Management
The app contains four Blocs:
                                      
1- **User Authentication**:                  
   - AuthBloc.
   - ProfileBloc.
     
2- **Settings**:                                                            
   - ThemeBloc.
     
3- **Home screen & places**:                     
  - PlacesBloc.

  -------------------

## Pages & Features

### 1. Signup Page
- **Input Fields**: Full Name, Email, Password, confirm password, Phone Number (optional).
- **Data Handling**: Input data is saved in variables.
- **Navigation**: Includes a **Signup** button that directs users to the **Login Page**.

### 2. Login Page
- **Input Fields**: Email and Password.
- **Validation**: Checks credentials against saved data.
- **Navigation**: Successful login redirects users to the **Home Page**.

### 3. Home Page
- **Suggested Places to Visit**: Displays attractions in a grid view.
- **Popular Places Section**: Displays horizontally scrollable cards for popular attractions.
  - Each card includes:
    - Image of the place.
    - Name of the place.
    - Governorate name.
    - The place's description.
    - A favorite icon (toggle on/off).

### 4. Governorates Page
- Displays a list of governorates.
- **Navigation**: Selecting a governorate navigates to a page showing landmarks specific to that governorate.

### 5. Profile Page
- Displays user details including:
  - Full Name
  - Email
  - Address
  - Phone number
  - Password (hashed for security).

### 6. Favorites Page
- Displays a list of favorite places.
- Static cards similar to the **Popular Places** section.

### 7. Bottom Navigation Bar
- Visible on main pages: **Home**, **Governorates**, **Favorites**, **Profile**.
- Includes icons for easy navigation:
  - Home
  - Governorates
  - Favorites
  - Profile

### 8. Page Navigation Animations
- Smooth animations for transitions between pages.
- SlideRightRoute
- FadeTransitionRoute

### 9. Localization
- Apply localization feature (Ar and En) to adapt the app to different languages and regions.
- Using easy localization package.

### 10. Theme feature
- Allow manually toggle between light and dark modes.
- Using theme bloc.
                                                                                       
**New**----------------------------
### 11. Google Maps Integration for Landmarks
- Enhance the Government Page by including Google Maps functionality for each landmark.
- Display a Google Map widget in each landmark's details page with a marker indicating the landmark's location.
- When the map is clicked, the user is redirected to Google Maps with the landmark's longitude and latitude to start navigation.

### 12. Profile image Management
 - Apply changing profile image feature.
 - The user can change his image from Gallery or Camera.
 - Also, delete profile image option provided.

### 13. Authentication using fingerprint auth
 - The user cannot access his profile before scanning his fingerprint for security.
 - If the user device does not support biometric authentication, it will be redirected to the profile
   page (assuming that the user is authenticated).
 - Auth done using local auth package.

## Permissions Used:
In AndroidManifest.xml file:
 - android.permission.USE_BIOMETRIC.                                     
 - android.permission.USE_FINGERPRINT.                              
 - android.permission.INTERNET.
 - android.permission.CAMERA
 - android.permission.WRITE_EXTERNAL_STORAGE -> to save image file locally.

## Navigation Flow
1. **Login Page** → **Signup Page** → **Login Page** → **Home Page**
2. **Home Page** → **Governorates Page** → **Landmarks Page** → **Landmarks details**
3. **Home Page** → **Favorites Page**
4. **Home Page** → **Profile Page**

------------

## Screenshots

|  Google maps widget            | Change profile options                 | Change profile Output         |
| -------------------------------| ---------------------------------------| ------------------------------|
| ![Place det](place_details.png)| ![Profile options](change_profile1.png)| ![Output](change_profile2.png)|

-------------------------

## **Packages Used**
- **SharedPreferences**: For local data storage and offline support ==> https://pub.dev/packages/shared_preferences.
- **easy_localization**: For localization feature ==> https://pub.dev/packages/easy_localization.
- **flutter_bloc**: For state management using bloc ==> https://pub.dev/packages/flutter_bloc.
- **firebase_core**:  For using the Firebase Core API ==> https://pub.dev/packages/firebase_core.
- **firebase_auth**: For using Firebase Auth and enabling authentication using email and password. ==> https://pub.dev/packages/firebase_auth.
- **cloud_firestore**: for Cloud Firestore, a cloud-hosted, noSQL database with live synchronization and offline support. ==> https://pub.dev/packages/cloud_firestore.
- **skeletonizer**: For skeleton loading effect and enhance user experience during web or app loading. ==> https://pub.dev/packages/skeletonizer.                                               
- **New**------------------------
- **google_maps_flutter**: For using google maps ==> https://pub.dev/packages/google_maps_flutter.
- **url_launcher**: For launching google maps outside the app with specific location ==> https://pub.dev/packages/url_launcher.
- **image_picker**: To enable the user to change his picture by picking images from the image library, or taking pictures with the camera ==> https://pub.dev/packages/image_picker.
- **path_provider**: To get the file download path from the user phone and save image file locally  ==> https://pub.dev/packages/path_provider.
- **local_auth**: To allow local authentication via fingerprint  => https://pub.dev/packages/local_auth