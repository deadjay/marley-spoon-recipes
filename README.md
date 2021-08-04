# Marley Spoon Recipes
A test task / app example for Marley Spoon Co.
A simple iOS App which connects with `cdn.contentful.com` server and displays recipes on List and Detailed screens (Modules)

### How to run the project?

1. Clone the repo
2. Open Terminal and navigate to repo folder
3. Run `pod install` (make sure your have latest [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation)), pods will be installed and new  .xcworkspace file will be created.
4. Double click on `MarleySpoonRecipes.xcworkspace`
5. Choose Simulator version and press Run

### Project Uses:

- Minimum iOS Deplyoment Target "13.0"
- Pods: `PureLayout` for autolayout in code and `.xib` for autolayout on-screen
- `URLSession` for Networking
- `Decodable` for deserializing
- Also: one Coordinator, one NavigationController, two Unit Tests and some UIKit extensions
