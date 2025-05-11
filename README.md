# *FIND YOU* – iOS App 
*FIND YOU* is a SwiftUI-based iOS app designed to help international students and local residents discover, collect, and participate in nearby cultural activities.
In addition to its user-friendly interface and geo-based event recommendations, the app also features **merchant accounts** that allow verified users to publish events, attracting local attention in real-time and potentially generating revenue through participation, sponsorships, or foot traffic.
This dual-purpose design ensures that the app is not only socially useful, but also **financially sustainable** in future iterations.

## GitHub Repository
 [GitHub Project Link](https://github.com/GCraddit/IOS-GroupApp/tree/main)

 ## 🎯 Target Audience

The Local Explorer app is designed for three primary user groups:

- **International students** who are new to the city and want to discover nearby cultural or social activities.
- **Local residents** looking for fun or meaningful events in their area.
- **Small business owners and event organizers** who want to promote local events (e.g., night markets, art shows, food pop-ups) and attract nearby users through geo-based notifications.

By supporting both attendees and organizers, the app builds a two-sided cultural ecosystem.

## 🚩 Problem Solved

In large cities, many people—especially international students or newcomers—often miss out on local activities because they:

- Don’t know what’s happening nearby,
- Don’t follow the right social media channels,
- Or can’t find reliable local event apps.

At the same time, small event organizers and local merchants struggle to promote their events to nearby audiences without expensive ads or marketing tools.

**“FIND YOU” bridges this gap by:**

- Showing personalized event lists based on the user's location,
- Allowing users to browse, favorite, and revisit local events easily,
- Letting verified merchants post new events and automatically notify nearby users within a 3 km radius.

This makes event discovery easy, and community-based promotion affordable and effective.

## Comparison with Existing Solutions

While existing platforms like **Facebook Events**, **Eventbrite**, or **Meetup** offer event listings, they often:

- Require account connections or subscriptions,
- Promote large-scale or sponsored events over local ones,
- Lack location-based notifications for nearby activities,
- Have complex UIs not optimized for casual cultural browsing.

**FIND YOU** stands out by:

- Focusing on hyper-local, small-to-medium scale cultural events,
- Supporting both attendees and merchants in the same app,
- Providing instant visibility through **geo-based push notifications** (within a 3km range),
- Offering a minimal, intuitive interface built entirely with **SwiftUI**,
- Allowing users to explore without mandatory sign-up or external services.
- **Short-term discovery**: Unlike Meetup’s long-term group focus, our app is designed for **quick, spontaneous local engagement**—e.g., a food truck popping up or a weekend art show.

It’s designed to be as accessible as possible for students, locals, and small business owners alike. And it aims to be the go-to app for discovering **what's happening nearby right now**, not next month.

## 🧪 How to Use the App

Local Explorer offers two distinct experiences based on the user type: regular users and merchants.

---

### 👤 For Regular Users:

1. **Sign In**  
   Log in using your email and password. No third-party login required.

2. **Browse Events**  
   Use the Home tab or Dashboard to explore nearby events, segmented by:
   - My Events
   - Favorites
   - Following

3. **View Details & Favorite Events**  
   Tap on any event to view details and add it to your favorites.

4. **Receive Notifications**  
   If a nearby merchant posts an event within 3km, you'll be notified instantly.

---

### 🧑‍💼 For Merchants:

1. **Login with Merchant Account**  
   Merchants use designated accounts with `isMerchant = true`.

2. **Create a New Event**  
   Go to the “New Event” tab to:
   - Add a title, image, summary, and max participants
   - Pick an event category
   - Enter an address or drop a pin on the map

3. **Post & Notify Nearby Users**  
   After posting, the event is added to the global list. If you're a merchant, nearby users within a 3km radius will **receive a notification** automatically.

4. **Monitor Posted Events via Dashboard**  
   Merchants can track their own events from the Dashboard view under “My Events”.

---

### 🔁 Seamless Tab Navigation

The app uses a bottom tab bar with:
- 🏠 Home
- ⭐ Favorites
- ➕ New Event
- 🧑 Dashboard

Navigation is intuitive, designed for quick browsing and participation.

## Frameworks / Services Used

The following tools and frameworks were used to implement Local Explorer:

- **SwiftUI**  
  Declarative UI framework used to build all views, tab navigation, forms, and reusable components.

- **MapKit**  
  Used for displaying maps, selecting event locations, and visual feedback for geolocation.

- **CoreLocation**  
  Powers the distance calculations and determines which users are within 3km of a newly posted event.

- **@State / @StateObject / @EnvironmentObject**  
  Used for effective state management and shared data access across views.

- **AppStorage**  
  Stores login states persistently across sessions using `UserDefaults`.

- **Custom ViewModels**  
  Includes `UserSession` and `EventViewModel` to separate UI from business logic and maintain loose coupling.

- **Form Validation & Error Handling**  
  Includes error alerts for geocoding failures and login state verification using `.alert()` and `.sheet()` patterns.

This architecture ensures modularity, reusability, and extensibility while maintaining high performance on iOS devices.

## Major Technical Challenge

###  Geocoding Addresses into Coordinates (Main Challenge)

One of the trickiest parts was converting user-inputted addresses into precise map coordinates using `CLGeocoder`.

#### The Problem:
- Users can type any string as an address.
- Invalid or partial inputs may fail silently or produce unexpected locations.
- SwiftUI forms are asynchronous, and coordinating error handling with UI feedback is non-trivial.

#### Our Solution:
- When users type an address and press return, we attempt to geocode it.
- If the geocoding fails, we show a user-friendly `.alert()` explaining the issue.
- We also allow manual pin-drop as a fallback.

```swift
geocoder.geocodeAddressString(address) { placemarks, error in
    if let location = placemarks?.first?.location {
        selectedCoordinate = location.coordinate
    } else {
        showGeocodeError = true
        geocodeErrorMessage = "Could not locate the address. Try again or use the map."
    }
}


## Iterative Product Design

We followed an **iterative product design cycle** to develop our minimum viable product (MVP). Here’s how our app evolved over time:

---

### 🧪 Phase 1 – Planning & Paper Prototyping
- Defined user personas: student, local resident, and merchant.
- Sketched out user flows and interface screens (e.g., tab layout, event card, profile).
- Focused on lightweight and mobile-friendly experience.

---

### 🛠 Phase 2 – Initial Development
- Built core data models: `User`, `Event`, and `UserSession`.
- Set up main navigation tabs and created mock data for testing.
- Implemented event list, favorite system, and merchant publishing form.

---

### 🧭 Phase 3 – Core Logic & State Management
- Added `MapKit` integration for map selection and event location.
- Implemented geocoding and error handling using `CLGeocoder`.
- Built location-based notification system (users within 3km of new events).

---

### ✅ Phase 4 – Minimum Viable Product Achieved
- All key features operational:
  - Sign in/out
  - Event listing + favorites
  - Event creation by merchants
  - Notification broadcasting
- Focused on UI polish, responsiveness, and tab interaction.

---

Each phase informed the next. Through small, testable iterations, we were able to deliver a working, user-focused MVP.

## 👥 Team Contributions

| Name            | Student ID | Role                            | Key Contributions                                                                 |
|-----------------|------------|----------------------------------|------------------------------------------------------------------------------------|
| Qiwei Chen      | 24669588   | Lead Developer & System Design  | Designed core app structure, implemented login logic, state management, and UI flow |
| Shuoyan Xia     | 24914119   | Feature Developer & Geolocation | Developed event posting form, map integration, geocoding logic, and form validation |
| Wenquan Zhang   | 25224243   | UI/UX Designer & QA             | Built user-facing views like Home, Favourites, Dashboard, and handled UI testing and refinement |

Each team member contributed equally to the planning, design, and debugging of the app.






























