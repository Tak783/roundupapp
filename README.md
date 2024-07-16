# Round Up
Round up app for Starling Engine

## Preface
1. The project uses a highly modular approach using platform-agnostic components
2. SOLID principles were applied focusing on simplicity and flexibility during the development
3. Unit and integration written using TDD and BDD using the FIRST principle approach to tests written across the project
4. Tests were written mostly for Business logic. Presentation layer tests will be written with more time.
5. Core functionality delivery was prioritised. UI&UX can be improved.
6. This README also contains "#Architectural decisions reasoning", "#How to use" and "#improvements" sections

There are many ways of approaching an iOS project, this is one way. Other ways are possible depending on the project, team and phase.

## How to use
* Please add your own Access and Authentication Tokens to the scene delegate

*In the future keychain storage manager will be used, currently using `UserDefaultsAuthenticationStoreManager`. Provisions for the keychain solution were made using `AuthenticationStoreManagable`*

## Overview 

### Architecture 
* The App is built on top of multiple Platform-Agnostic Swift Packages that live in Layer folders - as discussed in the "# Platform agnostic components" section
* There 7 layers. At the lowest level are Foundational components (i.e. extensions to Foundation), and at the highest level is the Presentation Layer which contains the iOS app 
* Highly modular. Each of the bottom 5 layers is platform agnostic so that packages can be used by either UIKit, SwiftUI WatchOS etc. 
* There is Vertical use of dependencies: each package can import *only* from layers below.

<img width="1280" alt="Architecture" src="https://github.com/user-attachments/assets/23533bfb-8fa6-462c-a848-76f2613f2ae7">

### Platform agnostic components
The app is built with platform-agnostic components for the following reasons.
* Easily use in Mac, iOS, iPadOS, WatchOS apps using either UIKit, WatchKit or SwiftUI
* Highly *reusable* components that can easily be used to support other feature layer components and Presentation Layer Application targets
* Faster *build times* for tests, testing suites and projects locally and on pipelines. 
* Easier *collaboration* between teams (everything does not happen in one place)
* Easily use new technologies i.e. SwiftUI or Combine
* Built with Consideration for *open source* capability and *demo apps* as layer components are independent and rely on abstractions rather than concrete implementation.

### Design and Development 
* Application of SOLID principles and a relatively extensive unit and integration testing suite. The rest of the UITests will come.
* App Built-in a TDD way, to ensure the functionality works as expected, providing protection from regressions 
* Development *Focus* was on functionality, Architecture, Testing and engineering of highly reusable platform-agnostic components used in the presentation app target rather than the UI or UX. 

## Architectural decisions 

### Layers (overview)
* As seen in the overview, the app has Four layers: Core, LiteBank, Feature and Application Target layer
* Vertical dependencies: each layer contains modules used as dependencies by higher-level modules. Modules can be imported only from the layers below. 
* Each module lives in its own independent project with as few dependencies as possible and contains its own tests, this way each feature can be
   *  Built-in isolation without building the entire Presentation Layer Target 
   *  Be highly reusable, open sourceable and able to be used in demo apps
   *  Be platform agnostic usable in any presentation application target platform

### Core Layer (explained)
Contains foundational shared frameworks to be shared across multiple presentation layer app targets i.e. business and retail 
* CoreFoundational: contains extensions to the `Foundation` framework. These are used across Feature frameworks and the app.
* CoreTesting: contains extensions and helpers for XCTest to support the testing suites in higher-level layers

### Core Shared Components Layer (explained)
* CoreNetworking: contains the networking layer
* MockNetworking: has supporting components used for mocking the networking layer during Unit and Integration tests

### Core Starling Engine Layer (explained)
Contains Engine specific components (share across apps i.e. business and retail)
* CoreStarlingEngineSharedModels: Core models/interfaces to be used for Engine apps i.e. `Amountable` - used later in all of the Feature Layer frameworks 

### Core Feature Layer Presentation Layer Helpers (explained)
Contains platform-agnostic components and extensions used by higher layers to support their uses in the presentation layer
* CoreFeatureLayerPresentationHelpers: Does the above

### Feature Business Logic Layer (explained)
Contains Feature level Businesss logic for framework modules containing features. Frameworks have API, Service and Presentation Layers.
* Account Feature: Accounts Feed, Create New Savings Goal, Add To Savings Goal
* Savings Goal Feature: Savings Goal Feed, Create New Savings Goal, Add To Savings Goal

### Core Presentation (explained)
* CoreUIKit: contains extensions to the `UIKit` framework.
* CorePresentation: Contains Navigational components i.e. the coordinators and alerts, components core to the presentation layer. These can be used for UIKIt and SwiftUI etc.
  
### App Presentation Layer (explained)
Application Layer: Where apps Mac, iOS, iPadOS, Watch OS projects and exist and present feature-level components. The apps are supported by lower level components.
* RoundUp app: App for saving based on round-up of weekly transactions

## Improvements 

### Must Have Changes
* OAuth + Token manager
    * This project APIs are currently sandbox level, I have opted to just use `UserDefaultsAuthenticationStoreManager` to store and manage the tokens. 
    * In the future keychain storage manager will have be used 
    * Accommodations for a future `KeychainAuthenticationStoreManager` were made with the currently existing `AuthenticationStoreManagable`
    * In production token exchange would be used to return new access tokens 
* Integration tests for view controllers and UIViews
* Architecture update to use more inversion of control as part of the Single Responsibility Principle (SRP)
    * Composers would be the bridges between packages that interact together instead of the View Controllers
    * The above would lead to better application of the SRP as the VC would only consume the objects leaving creation and injection to the composer
* Core Networking package to use Async Await
    * This would make the networking layer more up-to-date with current iOS trends
    * The one in place is fully unit tested hence its use over other packages I have for Async Await
* Project Updates
    * Add Swift Lint to enforce a style
    * Make all testing suites run tests in parallel to make sure tests run successfully without order dependencies 
* Add Feature specific string files for each feature so that each feature comes ready out of the box to have a presentation layer added
* Add rest of UITesting Suite UITests
* Additions to features 
  * Enable a `DatePicker` (header view model needs an upgrade to support the addition of date selection)
  * Enable pull to refresh 
  * Use the balance API to show account totals
  * Show transaction totals
  * UI polish

### Should
* Feature UI Layer
  * Move feature UI code away from the iOS app to their own independent packages so they can be more independent which would lead to
    * Faster test times and development times, ability to create and use Demo Apps
    * Better application of SRP, Open Closed, and Dependency Inversion
    * More modularity as we can more easily remove them from the app or switch the internals of the package i.e. from UIKit to SwiftUI
* Feature Packages 
    * Move `ViewModel.failure` messages to Strings files 
    * `TransactionFeedItemViewModel` Handle Spending Categories: - Issue found during p1-00005-round-up
    * Add pull to refresh to all feeds
*  Add a new `AccountsFeatureTesting` Framework to move domain-specific mock data from `CoreTesting` to a new  `AccountsFeatureTesting` framework i.e
    * Moving `Accounts.json` and `TransactionFeed.json` into `AccountsFeatureTesting`
*  Add a new `SavingsGoalFeatureTesting` Framework  and move domain-specific mock data from `CoreTesting` to a new  `SavingsGoalFeatureTesting` framework i.e
    * Moving `SavingsGoals.json` and `SavingsGoals.json` into `SavingsGoalFeatureTesting`
* Unification 
    * Unify `***FeedViewModelTestsSpec` into one spec as they all seem to be doing the same thing + any other similar specs 
    * Unify the `Error` in the Services for each feature into one place + support this change in `CoreNetworking
    * Unity the testing suites and protocols for the services and models for they are very similar. i.e. a new `FeedServicable` or `ViewModeallable`. I did not do this because I think that they should remain open for now as each is bound to change in an array of directions. But, if we are adhering to interface segregation, then this might be ok
    * Additional spec files for tests.
 
Thank you for your consideration.
