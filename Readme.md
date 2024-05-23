# SwiftUI Practice

A SwiftUI app with a TabView of Views used to demonstrate `@State`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject` and related SwiftUI data-passing methds and how to write unit tests for them.

There is also some tests to help describe how to use Combine.

## Suggested Learning Flow

- Show the simple `@State` view.
- Explain structs, classes and property wrappers (TODO: `StructTests.swift`)
- Show the other types of SwiftUI property wrappers (`@StateObject`, `@ObservedObject`, `@EnvironmentObject`).
- Understand that `@ObservedObject` uses Combine internally.
- Learn about Combine through `CombineTests.swift` and `CombineExamplesTests.swift`.

## Notes

- This app targets iOS 16 so some of the newer SwiftUI features (like `@Observable`) could not be used. This is intentional as of the date that was made iOS 16 is `current version - 1` which is generally the accepted minimum version to support.
- Unit tests for most views exist and were written using the [View Inspector](https://github.com/nalexn/ViewInspector) library.
- The app icon is from [this free icon pack](https://reffpixels.itch.io/genericicons), however I upscaled it to 1024x1024 so it works as a single file app icon.
- The Swift by Sundell [article about state management in Swift UI](https://www.swiftbysundell.com/articles/swiftui-state-management-guide) covers a lot of the same material as these examples.
- The Swift by Sundell [Discover Combine](https://www.swiftbysundell.com/discover/combine/) section is also a great introduction. See CombineTests.swift for more resources and examples.
