# 0
swiftenv local 3.0.2

# 1
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

### 7.2




# 8
