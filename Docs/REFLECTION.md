# Reflection

## Which part of your submission are you least confident about, and why?

The part I'm least confident about is the animation for the Top Rated section. I don't frequently build custom animations in SwiftUI, so although the current implementation works and feels smooth enough for the assignment, I know there are more polished approaches. If I had more time, I would explore different animation techniques and experiment with improving the interaction without sacrificing performance or accessibility.

---

## Describe a moment during this project (or any past project) where you got completely stuck. What did you do, step by step?

I got stuck while implementing the data loading flow. The application kept entering the error state and showing the error modal even though the network request itself was successful.

At first, I suspected the problem was related to pagination or my loading state because those were the most visible symptoms. After discussing several possible causes and trying a few hypotheses, the issue still remained.

Instead of continuing to guess, I started debugging step by step:

1. Added debug logs around the networking and decoding process.
2. Printed the decoding errors to identify the exact failing property.
3. Compared the API response against my data models.
4. Found that several fields from the TVMaze API (such as `summary`, `image`, and `rating.average`) could be `null`, while my models expected non-optional values.
5. Updated the models to correctly match the API response and verified that the issue was resolved.

---

## Imagine: it's Thursday, your task is due Friday, and you realize you misunderstood the requirement, so half your work is wrong. What are you doing now?

First, I would identify exactly which requirement I misunderstood and determine the root cause. Then I would estimate how much of the implementation is actually affected instead of assuming everything needs to be rewritten.

After that, I would break the work into smaller tasks, estimate the effort for each one, and prioritize the changes that are necessary to meet the requirements. If there is any risk of missing the deadline, I would communicate it as early as possible rather than waiting until the last minute. My focus would be on delivering a correct solution, even if it means reducing lower-priority improvements or polishing work that can be postponed.

---

## Your mentor asks you to change an approach you believe is worse. What do you do?

I would first try to understand why they are recommending that approach instead of immediately defending my own solution.

There may be reasons that I am not aware of, such as business priorities, consistency across the codebase, technical debt, avoiding known anti-patterns, or long-term maintainability. If those reasons are valid, I am happy to follow the recommendation even if it is different from my initial preference.

If I still believe another approach would be better, I would present it respectfully with supporting evidence, such as documentation, performance considerations, or previous experience. If my approach introduces risks or blockers, I would also explain those openly and discuss possible compromises. I value making the best decision for the team more than proving that my original idea was correct.

---

## What's something technical you taught yourself recently outside of class/work, and how did you learn it?

One recent topic I spent time learning outside of work was RxSwift.

Although I used RxSwift in my job, I wanted to understand it more deeply instead of only using existing patterns. I started by reading *RxSwift: Reactive Programming with Swift* from CodeCademy (formerly Ray Wenderlich, now Kodeco), watched conference talks and YouTube videos, and experimented with small sample projects.

I also asked my mentor if I could spend additional time discussing concepts that I found difficult. To reinforce my understanding, I created my own learning materials and presented what I had learned to my mentor so they could give feedback and correct any misconceptions. Teaching the concepts back to someone else helped me understand them much better than simply reading documentation.
