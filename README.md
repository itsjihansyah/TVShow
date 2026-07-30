# TVShow

A native iOS application built with **SwiftUI** that allows users to browse TV shows from the TVMaze API, filter shows by genre, and view detailed information. The app focuses on clean architecture, responsive UI, loading states, and modern Swift concurrency.

<img width="1984" height="2040" alt="image" src="https://github.com/user-attachments/assets/774233c2-40a1-494e-969c-412afd6dd530" />

## Features

- Browse TV shows
- Infinite scrolling (pagination)
- Filter TV shows by genre
- Top Rated carousel with auto-scroll
- View TV show details
- Share TV show information
- Pull to refresh
- Loading, success, and error states
- Image retry handling

## Tech Stack

- Swift
- SwiftUI
- async/await
- Combine
- URLSession
- XCTest

## Architecture

- MVVM

## Requirements

- Xcode 16+
- iOS 18.0+

## Project Structure

```
TVShow
├── App
├── Model
├── View
├── ViewModel
├── Network
├── Common
```

# How to Run

1. Clone the repository
2. Open the project

```bash
open TVShow.xcodeproj
```

3. Select an iOS Simulator
4. Run the application

*No API key is required since the project uses the public TVMaze API.


# Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture to separate presentation, business logic, and networking concerns.

## Layers

### View

Responsible only for rendering UI and forwarding user interactions.

Examples:

- HomeView
- ShowDetailView

### ViewModel

Contains presentation logic and exposes observable state for the views.

Responsibilities include:

- Fetch data
- Pagination
- Genre filtering
- Navigation state
- View state management

### Service

Responsible for communicating with external APIs.

Responsibilities:

- Building requests
- Executing network calls
- JSON decoding
- Error propagation

### Model

Represents decoded API responses.

Examples:

- TVShow
- Rating
- Image

# Architecture Decisions

## MVVM

**Reason**

- Separates UI from business logic, making the application easier to maintain and test.

**Trade-offs**

- For a relatively small application, MVVM introduces additional files and abstractions compared to placing logic directly inside views.

## Generic API Service

**Reason**

- A single generic networking layer (`fetchData<T>`) minimizes duplicated networking code while remaining reusable for future endpoints.

**Trade-offs**

- Generic networking requires slightly more abstraction and careful decoding configuration.

## Swift Concurrency (async/await)

**Reason**

- Swift's structured concurrency provides readable asynchronous code without callback nesting.

**Trade-offs**

- Requires iOS 15+ and understanding task cancellation and structured concurrency.

# Testing

The project follows Test-Driven Development and includes unit tests covering:

- ViewModel business logic
- Genre filtering
- Pagination behavior
- Networking using mocked services

# Documentation

Additional documentation can be found in the `docs` folder.

- AI_LOG.md
- CODE_REVIEW.md
- Walkthrough Video:

[<img width="895" height="505" alt="TV Show App Walkthrough" src="https://github.com/user-attachments/assets/b02be2ac-91b0-4660-b527-0440c2775f48" />](https://youtu.be/JdgGZwaxn7Q)

Link: https://youtu.be/JdgGZwaxn7Q

# What I'd Improve with More Time

- Add image caching using a dedicated caching layer (e.g. CachedAsyncImage)
- Add offline support
- Add network error handler
- Add UI tests and snapshot tests
- Add search functionality
- Add sorting options (rating, name, premiere date)
- Improve carousel gesture handling for edge cases
- Improve view and image state handler

# Known Limitations

- Images rely on TVMaze image URLs and may occasionally fail to load.
- Pagination is triggered when the last visible card appears, which may fetch slightly earlier than expected.
- Carousel implementation relies on repeated data and scroll position recentering.

# API

TVMaze API: https://www.tvmaze.com/api

- `GET /shows`
- `GET /shows/{id}`

# Author

Jihan Syahira Adnanda Putri
