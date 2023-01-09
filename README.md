# Speer Technologies iOS assessment

## Assumption
1. There was no URL given for JSON and I created a local JSON file
2. It was not clear what avatar's data type is and I assumed it's a URL to user profile image
3. When user taps on Follower/Following, it goes to next screen and shows the list of Follower/Following.
 It was not clear if X Follower/ X Following labels on the second screen should be tappable or not. 
 It's assumes they are not tappable
4. When search result is empty, app uses a different UITableviewCell as the "Not Found" view
5. It was better if each user had a unique ID and Follower/Following arrays were filled with just ID's. Since a user does not have an ID, Follower/Following arrays have repeated users.
6. It was clear how Follower/Following labels should behave if the count is 0. I added at least one follower and one following for each user

## Overview

The goal of this assessment is to build a basic iOS application which demonstrates common tasks such as fetching data, parsing model entities from JSON, UI, and navigation. You may write the app using what you're most comfortable with, whether it's Storyboards, pure UIKit, or SwiftUI. You are also free to code in either Swift or Objective-C.


### Requirements

For this asessment you'll need to familiarize yourself with parts of the [GitHub REST API](https://docs.github.com/en/rest). The required features we'd like to see built are:

1. A search bar that enables us to fetch GitHub user profiles by username:
    - If no user exists with the username provided, present a "Not found" view
    - If the user exists, present a view with that user's:
        1. Avatar
        2. Username
        3. Name
        4. Description
        5. Follower count, i.e. *X followers*
        6. Following count, i.e. *X following*
2. A view which displays a list of the user's followers, as well as a view for who they're following 
    - We should be able to navigate to this view by tapping on the follower/following counts 
    - If a user in this list is tapped, it should navigate us to their profile view
3. The ability to navigate backwards through the navigation stack

Show us what you can do in no more than 24 hours. Keep a log of the time spent and include it with your submission. Note that there are no designs to follow for this assessment, so you have creative freedom when it comes to the layout and so on.

##### Bonus features

These features aren't mandatory, but if you have extra time and want to stand out feel free to add any of the following:

- Skeleton screens
- Pull to refresh
- Profile caching & cache invalidation


### Grading

This exercise will be graded on a number of criteria including, but not limited to: 
- Clean, readable, and well documented code
- Adherence to the SOLID principles
- Utilization of an architectural pattern, e.g. MVC, MVVM, VIPER


### Submission
After you're done with the assignment, please submit a link to the **GitHub/Bitbucket repository** (make sure it's public) with your code. Submissions without a valid repository will be removed from any further consideration.


#### Goodluck!
