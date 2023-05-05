# AstroHunt

## Introduction
iOS  app with Swift and SwiftUI

AstroHunt is a sample iOS app that demonstrates how to use the MVVM architecture pattern. It allows users to browse a list of astronauts, their information, and a detail view of their bio and flights.

## Installation

To run AstroHunt, you'll need to have Xcode installed on your Mac. You can download the latest version of Xcode from the Mac App Store or from the Apple Developer website.

Once you have Xcode installed, follow these steps to run the app:

Clone the AstroHunt repository to your local machine.

Open the MyApp.xcodeproj file in Xcode.

Switch to data-persistence branch.

Select a simulator or a connected iOS device from the scheme menu in the Xcode toolbar.

Click the "Run" button or press Command+R to build and run the app.


## Architecture

The app uses the MVVM architecture pattern, which separates the app into three components:

### Model: 

This component represents the data and business logic of the app. In MyApp, the model consists of a single data model that represents an item.

It's named Model and contains Astronaut file which contains data related to the Astronaut.

### View: 

This component represents the user interface of the app. In MyApp, the view consists of several view controllers that display information to the user and respond to user input.

There are several view in the app and are under folder named as Views

### ViewModel: 

This component acts as a mediator between the Model and the View. In MyApp, the view model provides data and actions that the view can use to display information and respond to user input.

I have placed it under Utilities folder. 

NetworkManager ViewModel is taking care of api calls and downloading api call response to a file.

AppLoginManager is looking after login and logout logic of the app using facebook api and biometrics like faceID.

AppDelegate is actually a part of AppLoginManager and supporting facebook operations.

