# Movie Catalog

This is a simple app that is a sort of clone of the Apple TV app to show how I organize code in a "real" project, as in
the project is simple, but the techniques and care are at the level of my day-job code.

Some ideas may be simplified of course, but in general it's a good indication on how my day-job app looks like in code.

## Setup

First make sure you have an `API_KEY` setup in `MovieCatalog/Config/BaseConfig.xcconfig`.
You get a value from http://developer.themoviedb.org/reference/trending-movies

## Techniques used

There are a lot of details used in this code base, like:
- dependency injection of networking via the environment
- snapshot testing that works with xcode cloud for iOS target
- snapshot testing that works with xcode cloud for SPM packages
- use of test plans
- modularization with local SPM packages
- advanced navigation
- the view data pattern
- apple-tv like style of loading screens
- deep linking

---

# Videos

Here are the list of videos that are related to this project.

The code would look different from the videos, as I keep extending it. I will also add links to the specific state of
the code at the time of the video

## 1. Building UI that is easy to Preview and Test with SwiftUI

Video: https://youtu.be/KZBr0wlS3K0

Code at this time: https://github.com/fespinoza/Youtube-SampleProjects/tree/movie-catalog/full-app

## 2. Advanced Navigation for SwiftUI apps

Video: https://www.youtube.com/watch?v=Z-3ETLYbhFA

Code at this time: https://github.com/fespinoza/Youtube-SampleProjects/tree/movie-catalog-routing/00-routing-and-deep-links
