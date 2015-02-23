## Twitter Lite

This is a bare bones Twitter app which allows users to read and compose tweets using the [Twitter API](https://apps.twitter.com/).

To configure for local testing, add your Twitter API keys in the file `Twitter/TwitterClient.swift`.

Time spent: `6.5 hours`

### Features

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

### Walkthrough

![](http://i.imgur.com/qF493tF.gif)
