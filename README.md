# Egypt Tourist Guide - Mobile Application

## Project General Description

The **Egypt Tourist Guide** is a mobile application designed to help tourists explore landmarks, museums, and attractions across various Egyptian governorates. The app provides a user-friendly interface for discovering popular places, saving favorites, and managing user profiles. This project aims to enhance the tourism experience by offering curated suggestions and personalization.
it manages state using Bloc. (in controllers folder)

## State Management (BLOC)
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
  
------

## App Structure
The code is organized using **MVC Architecture** for clean and maintainable code structure.                   
The main folders in lib are:
- **controllers**: contains controllers which deal with presentaion layer to handle logic (auth bloc, places bloc, profile bloc, and theme bloc).
- **core**: define lang and services logic folders. also, the other general files in the app (lang folder, services folder).
- **models**: define the data models (place model, governorate model, user model, and screen model).
- **views**: UI design and components (screens and widgets).

-------------

## How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.

---------------------------------------

## Navigation Flow
1. **Login Page** → **Signup Page** → **Login Page** → **Home Page**
2. **Home Page** → **Governorates Page** → **Landmarks Page**
3. **Home Page** → **Favorites Page**
4. **Home Page** → **Settings Page**

-------
## Screenshots

| Home Page                | Governorates Page                        | Favourites Page                      |
|--------------------------|------------------------------------------|--------------------------------------|
| ![Home](home_screen.png) | ![Governorates](governorates_screen.png) | ![Favourites](favourites_screen.png) |

| Settings Page                    | Governorates Places                             | Home Page (dark and arabic)   |
|----------------------------------|-------------------------------------------------|-------------------------------|
| ![Settings](settings_screen.png) | ![Governorates Places](governorates_places.png) | ![Home Dark](home%20dark.png) |

-----
## **Packages Used**
- **SharedPreferences**: For local data storage and offline support ==> https://pub.dev/packages/shared_preferences.
- **easy_localization**: For localization feature ==> https://pub.dev/packages/easy_localization.
- **flutter_bloc**: For state management using bloc ==> https://pub.dev/packages/flutter_bloc.
- **skeletonizer**: For skeleton loading effect and enhance user experience during web or app loading. ==> https://pub.dev/packages/skeletonizer.
