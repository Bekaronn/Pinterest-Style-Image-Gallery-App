# Pinterest-Style Image Gallery App
Overview
This project is a Pinterest-style image gallery app built using SwiftUI. It downloads random images from the Picsum Photos API and displays them in a dynamic grid layout, similar to Pinterest. The app leverages the MVVM (Model-View-ViewModel) architectural pattern, implements proper concurrency using Grand Central Dispatch (GCD), and ensures smooth UI updates.

# Features
Core Features
- Download 5 random images: Each time the button is pressed, 5 new images are added to the existing gallery.
- Concurrent Image Downloads: Image downloading happens concurrently using background threads to ensure smooth UI performance.
- DispatchGroup Synchronization: A DispatchGroup is used to ensure that all images are downloaded before updating the UI.
- Pinterest-Style Grid Layout: A grid layout for displaying images in a responsive, Pinterest-style format.
- MVVM Architecture: The app follows the Model-View-ViewModel architecture for clean code organization.
- Asynchronous UI Updates: Ensures that the UI is updated after all images are downloaded.

# Advanced Challenges (Optional)
- Pull-to-refresh: The app supports pulling to refresh the image gallery.
- Image Caching: Cached images to avoid downloading the same image multiple times.
- Detail View: Tap on an image to open a detail view displaying additional information.
- Error Handling: Implements proper error handling for failed image downloads.
- Infinite Scrolling: The app supports infinite scrolling, loading more images when the user scrolls to the bottom of the gallery.

# DEMO VIDEO
Youtube link: https://youtube.com/shorts/7MmdRKq08yw

# Conclusion
This project demonstrates how to build a Pinterest-style image gallery using SwiftUI, Grand Central Dispatch for concurrency, and the MVVM architecture. The app handles asynchronous tasks efficiently, updates the UI seamlessly, and provides a smooth user experience with features like pull-to-refresh and infinite scrolling.
