# 0 Swiftenv
```bash
$ brew install kylef/formulae/swiftenv
$ swiftenv install 3.0.2
$ cd $project && swiftenv local 3.0.2
```

# 1 Create Project

```bash
$ mkdir $project && cd $project
$ swift package init --type executable
```

# 2 Dependencies
Add dependency Vapor to Package.swift
```swift
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3)
    ],
    exclude: [
        "Tests"
    ]
```

# 3 Update project
```bash
$ swift package update
$ swift build
```
And verify the result

# 5 Generate xcode project
```bash
$ swift package generate-xcodeproj
```

# 6 Hello, World!
```swift
import Vapor

let drop = Droplet()

drop.get { req in
    return "Hello, World!"
}

drop.run()
```

# 7 Deploy

## A: Heroku

### 7.1 Heroku setup
1. Create a new app in Heroku
2. Choose a deployment method (i.e. Heroku CLI or GitHub) 
3. Go to your app Settings on Heroku and add a buildpack: https://github.com/vapor/heroku-buildpack
4. Go to your app Settings on Heroku and copy your git repository url
5. Clone your repository and add your source code

### 7.1 git init 
(Ignore DerivedData)
```bash
$ git init
$ git add --all
$ git commit -am "First commit"
```

### 7.2 Add your project a configuration
```bash
$ touch Procfile
$ echo "web: .build/release/mts01e02 --env=production --workdir=./ --config:servers.default.port=$PORT" > Procfile
```

### 7.3 Push
Deploy using the Heroku CLI or by pushing to GitHub.

## B: IBM BlueMix

# 8 Slack

## 8.1 First step: slash-command

1. Join the slack team at ?
2. Go to settings and "Manage app" -> "Custom integration"
3. Create a slash-command and add your swift server url in "Integration Settings"
4. According to outgoing datas slack sends, create an appropriate response containing a giphy url and id

## 8.2 Second step: vote for giphy

https://fashicon.slack.com/apps/build
