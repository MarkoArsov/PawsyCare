# PawsyCare

**Developed by:**

- Marko Arsov **201135**
- Marija Chipishkova **203057**
- Marko Gjorgjievski **201136**

**Features:**

PawsyCare offers a range of features tailored to Pet Owners and Pet Service Providers. These features include:

1. **User Authentication and Data Storage:**
   - Firebase authentication is employed for user authentication.
   - Firebase is used for storing user data, pet information, locations, services, and bookings.

2. **User Interface Elements:**
   - Custom UI elements designed for an intuitive user experience include:
     - App bar
     - Registration and sign-in forms
     - Cards displaying available services
     - Cards displaying pets
     - Map for navigation

3. **Software Design Patterns:**
   - **Singleton Pattern:** Firebase initialization is performed once for the entire application, enhancing efficiency.
   - **Observer Pattern:** UI updates dynamically in response to data changes.
   - **Stateful Widget Pattern:** Mutable state is managed, ensuring smooth user interactions.

4. **State Management:**
   - The app retains user and service provider data, ensuring a seamless experience across sessions.

5. **Services:**
   - Utilizes location services (Google Maps) for navigation.
   - Integrates camera functionality for various interactions.
   - Backend as a Service (BaaS) is provided by Firebase.

**Documentation:**

**Installation Requirements:**
Ensure you have the following installed on your computer:

- Flutter
- Dart SDK

Follow these steps to install the app:

1. Run the command `flutter pub get` to fetch dependencies.
2. Navigate to the project directory using `cd path/to/your/project`.
3. Execute `flutter run` to launch the app.

**Note:** Make sure to have Flutter and Dart SDKs installed before proceeding with installation.

**User Guide:**
Upon launching PawsyCare, users can:

- Register their pets.
- Browse and book services offered by registered providers.
- View all service provider locations on a map.
- Manage bookings via a calendar interface.
- Service providers can register their locations and services.
