# CastList - Find the movies/tv in common between your favorite actors/actresses
The concept of this app came from a question I couldn’t easily answer. It seemed like every movie Seth Rogen is in, James Franco is also in it. This app aims to answer that question and allow you to find out how many movies Chris Farley and David Spade are in together, Robert Downy Jr and Chris Evans are in together, etc. 

# API Initialization
- Most importantly, if you choose to build this in your environment, you will need an API Key. 
- This app uses The Movie Database on the backend, you can learn more about how to get an API Key [here](https://developer.themoviedb.org/docs/getting-started).  
- Once you have your api key, create a struct called TMDBAPIKey that conforms to TMDBKeyProtocol. 
-- Conforming to this protocol requires a static string property called key. 
- If you save this struct in its own file, I have setup in the .gitignore of this repo to ignore any file named `TMDBAPIKey.swift`. 

# Scope
- Ultimately, this is an app that connects to the TMDB API, searches for People and their respective productions. 
- Then compares two peoples productions to find commonalities.
- This requires iOS 16 and up. 
- This app has two package dependencies
    - [CachedAsyncImage](https://github.com/bullinnyc/CachedAsyncImage)
        - In summary, this is a SwiftUI view that handles downloading images from a server and caching them for later.
        - It is a well supported repo, as of writing it has had updates in the last few weeks. 
        
    - [TabTitleBar](https://github.com/SeekAndDefineBK/TabTitleBar)
        - In summary, this is a simple SwiftUI view that serves as an alternative to the default tab switcher.
        - This is a package that I open sourced for the world, as well as my own projects like this one. 
        
# Known Issues
- When you use the TabTitleBar element to change tabs, the withAnimation block appears to have no effect. In my initial research this could be an issue with SwiftUI’s TabView.  But more research is necessary. 
