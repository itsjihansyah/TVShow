# Code Review

Objective: I will act like a reviewer of your code.

## Code to review

```swift
class MovieViewModel: ObservableObject {
    var movies: [Movie] = []

    func loadMovies() {
        let data = try! Data(contentsOf: URL(string: "https://api.example.com/movies")!)
        movies = try! JSONDecoder().decode([Movie].self, from: data)
    }
}
```

## Problems found

### 1. Blocking network call on the calling thread
`Data(contentsOf:)` is a synchronous read. When you point it at a remote URL, it blocks the thread until the request completes or times out. If loadMovies() is called from main thread, the whole UI freezes for the duration of the request. Please use `URLSession`, which is built to run off the main thread and supports async/await.

```swift
let (data, response) = try await URLSession.shared.data(from: url)
```

### 2. Force unwrapped URL
```swift
URL(string: "https://api.example.com/movies")!
```
Force unwrapping URL is genuinely fine and pretty standard when the string is a hand typed that can never change at runtime. But to make it safer, we can guard it:

```swift
        guard let url = URL(string: "\(baseURL)/movies") else {
            errorMessage = "Invalid URL."
            return
        }
```

### 3. Force try on the network call
```swift
try! Data(contentsOf: ...)
```
Any network failure like no connection, timeout, and server error turns into a crash. This should be inside a do catch so the failure can be shown to the user instead.

```swift
do {
    // handle data
} catch {
    errorMessage = "Failed to load: \(error.localizedDescription)"
}
```

### 4. Force try on decoding
```swift
try! JSONDecoder().decode([Movie].self, from: data)
```
If the JSON shape doesn't match Movie exactly, this will crash too. Decoding failures are common enough during dev and API changes that this needs to be handled, not force-unwrapped.

```swift
do {
    movies = try JSONDecoder().decode([Movie].self, from: data)
} catch {
    errorMessage = "Failed to load: \(error.localizedDescription)"
}
```

### 5. `movies` is not `@Published`
```swift
var movies: [Movie] = []
```
VM conforms to `ObservableObject`, but the property doesn't notify SwiftUI of changes. This needs to be `@Published var movies: [Movie] = []`.

### 6. No loading or error state
Theres nowhere for the view to know a request is in progress, or that it failed. Without this, the UI has no way to show a spinner or an error message, it just sits there with an empty list. We can add:

```swift
@Published var isLoading = false
@Published var errorMessage: String?
```

### 7. No async
The function isnt use `async`, so once its on `URLSession`, the call site needs a `Task` to invoke it. There's also no way to cancel an in-flight request if the view disappears or the user triggers another load.

```swift
@MainActor
func loadMovies() async {
    // handle load movies
}
```

Called from a view like this, so SwiftUI cancels the task automatically if the view disappears:
```swift
.task {
    await viewModel.loadMovies()
}
```

### 8. No base URL separation
The endpoint URL is hardcoded as a full string. If there are more endpoints later, or a need to switch between stg and prod, this string needs to be separated into a base URL + path, ideally in one shared place rather than repeated per call.

```swift
private let baseURL = "https://api.example.com"
// later: URL(string: "\(baseURL)/movies")
```

## Fix recommendation

```swift
class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
 
    private let baseURL = "https://api.example.com"
 
    @MainActor
    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
 
        guard let url = URL(string: "\(baseURL)/movies") else {
            errorMessage = "Invalid URL."
            return
        }
 
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
 
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                errorMessage = "Server returned an unexpected response."
                return
            }
 
            movies = try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
        }
    }
}
```

## Nit

Consider moving the networking call itself into a small service type rather than calling `URLSession` directly inside the VM. It makes the VM easier to test since you can swap in a fake service.
