# AI Usage Log

## Reviewing the Project Architecture

### What I asked the AI / the problem I was solving
I mentioned the requirements to build the project (SwiftUI), and had decided to use other stacks: MVVM as the architecture and async/await (combine). I used AI to review my planned architecture and discuss whether the chosen technologies were appropriate for the project requirements. I also created a skeleton for the README.

### What it gave me
The AI compared different approaches and explained the trade-offs between keeping the architecture simple versus introducing additional abstractions.

### What I did
Modified. I choose the technologies that were relevant to this project and put the other recommendation as fyi.

### One thing the AI got wrong or that I verified myself
Some recommendations prioritized minimizing the implementation because the project was a take-home assignment. I intentionally disagreed with that approach and kept practices and a more structured architecture because they aligned with how I normally build Swift applications and made the codebase easier to test and maintain, even within a smaller project.

---

## Planning Unit Tests

### What I asked the AI / the problem I was solving
I followed a test-driven development workflow. Before implementing a new feature, I asked AI to help me complete the list the possible unit tests (afraid that i might missed some edge cases) that should exist so I could decide the expected behaviour before writing the implementation.

### What it gave me
The AI suggested test cases covering successful paths, failure cases, edge cases, and state changes.

### What I did
Modified. I selected some of the tests that matched the feature requirements and ignored tests that only verified simple property assignments or SwiftUI framework behaviour.

### One thing the AI got wrong or that I verified myself
Some proposed tests had little practical value, so I decided not to include them after reviewing the implementation.

---

## Debugging API Decoding Issues

### What I asked the AI / the problem I was solving
I asked AI to help investigate why the application entered an error state while loading specific genre filtering. I included my hypothesis which could be caused by pagination since the error happens when the shows value is small.

### What it gave me
The AI suggested the same as my hypothesis and give some approaches to fix.

### What I did
Rejected those suggestions after testing them. I added my own debug logging to inspect the responses and decoder output.

### One thing the AI got wrong or that I verified myself
The actual issue was caused by my data model not matching the API. Several fields such as `summary`, `image`, and `rating.average` could be `null`, causing decoding failures.

---

## Code Review and Refactoring

### What I asked the AI / the problem I was solving
After implementing several features, I asked AI to review my code and suggest possible refactoring opportunities. I created a custom review skill in Claude with references to Swift and SwiftUI best practices, common architectural patterns, performance considerations (such as image loading), security, animations, and general code quality guidelines.

### What it gave me
The AI suggested improvements such as introducing computed properties for formatting, simplifying some view code, removing dead code, extracting reusable logic, and identifying opportunities to improve readability and maintainability.

### What I did
Modified. I accepted suggestions that improved readability or maintainability without changing the architecture or introducing unnecessary complexity. I rejected recommendations that I felt reduced clarity or added little value for this project.

### One thing the AI got wrong or that I verified myself
One recommendation was to remove the iOS version availability check for features introduced in iOS 26 because the AI assumed the deployment target was iOS 26. I had already changed the deployment target to iOS 18, so the availability check was still required. I verified the project configuration and kept the conditional code.
