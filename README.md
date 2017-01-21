# 0 Swiftenv
swiftenv local 3.0.2

# 1 Create Project
Create directory, cd inside
```bash
$ swift package init --type executable
```

# 2
Add dependency Vapor to Package.swift
```swift
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3)
    ],
    exclude: [
        "Tests"
    ]
```

# 3
```bash
$ swift package update
```

# 4
```swift
$ swift build
```
And verify the result

# 5
```swift
import Vapor

let drop = Droplet()

drop.get { req in
    return "Hello, World!"
}

drop.run()
```

# 6
```bash
$ swift package generate-xcodeproj
```

# 7 Deploy

## A: Heroku

### 7.1 git init 
(Ignore DerivedData)
```bash
$ git init
$ git add --all
$ git commit -am "First commit"
```

### 7.2 Heroku setup
1. Create a new app in Heroku
2. Choose a deployment method (i.e. Heroku CLI or GitHub) 
3. Go to your app Settings on Heroku and add a buildpack: https://github.com/vapor/heroku-buildpack

### 7.3 Push
Deploy using the Heroku CLI or by pushing to GitHub.

## B: IBM BlueMix

# 8

---

# Slack

https://fashicon.slack.com/apps/build
