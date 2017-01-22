# 0 Swiftenv
```bash
$ brew install kylef/formulae/swiftenv
$ swiftenv install 3.0.2
$ mkdir $project && cd $project && swiftenv local 3.0.2
```

# 1 Create Project

```bash
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

## Alternative A: Code Only

```swift
import Vapor

let drop = Droplet()

drop.get { req in
    return "Hello, World!"
}

drop.run()
```

## Alternative B: Vapor CLI

```bash
$ brew install vapor/tap/toolbox
$ vapor new $project
$ cd $project
$ git init
$ vapor heroku init
$ vapor xcode
```

# 7 Deploy

### 7.1 Heroku setup

1. Create a new app in Heroku
2. Choose a deployment method (i.e. Heroku CLI or GitHub) 
3. Go to your app Settings on Heroku and add a buildpack: https://github.com/vapor/heroku-buildpack
4. Go to your app Settings on Heroku and copy your git repository url
5. Clone your repository and add your source code

OR 

```bash
$ brew install heroku
$ heroku login 
$ heroku git:clone -a $project-name
```

OR

```bash
$ git init
$ git add --all
$ git commit -am "First commit"
```

and add your heroku repository url

### 7.2 Add your project a configuration

```bash
$ touch Procfile
$ echo "web: .build/release/mts01e02 --env=production --workdir=./ --config:servers.default.port=$PORT" > Procfile
```

### 7.3 Push

```bash
git push heroku master
```

# 8 Slack

## 8.1 First step: search for a GIF via a slash-command

1. Use your current slack team or, if you haven't got one, join the slack team at https://mobilethings-s01e02.slack.com/x-132353121862-130967217520/signup
2. Go to settings and "Manage app" -> "Custom integration" (https://api.slack.com/custom-integrations)
3. Create a slash-command and add your Swift server URL in "Integration Settings"
4. According to outgoing datas slack sends, create an appropriate response containing a giphy url and id. In order to use the Giphy API, refer to: https://github.com/Giphy/GiphyAPI. The search endpoint is http://api.giphy.com/v1/gifs/search?q=[YOUR+QUERY]&api_key=dc6zaTOxFJmzC

## 8.2 Second step: vote for a gif

1. Go to settings and "Manage app" -> "Custom integration" (https://api.slack.com/custom-integrations)
2. Create a slash-command and add your swift server url in "Integration Settings"

Then, you need to add a Redis provider to your dependencies...

```swift
import PackageDescription

let package = Package(
    name: "ServerSideSwift",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3),
        .Package(url: "https://github.com/vapor/redis-provider.git", majorVersion: 1)
    ]
)
```

... and use it to persist votes ! (Tip: https://github.com/vapor/redis-provider)
