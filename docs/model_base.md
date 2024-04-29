# Blogger model diagram in UML

```plantuml
@startuml

class User {
  email : String
  username : String
  firstName : String
  lastName : String
}

class Article {
  title : String
  content : Text
  userId : integer
}

class Technology {
  title : String
  shortcut : String
  homepage : String
}

class Comment {
  title : String
  content : Text
  userId : integer
  articleId : integer
}

class Review {
  title : String
  content : Text
  userId : integer
  articleId : integer
}

class TechnologyAssignment {
  technologyId : integer
  articleId : integer
}

User "1" -- "*" Article
User "1" -- "*" Review
User "1" -- "*" Comment

Article "1" -- "*" Review
Article "1" -- "*" Comment

Article "1" -- "*" TechnologyAssignment
Technology "1" -- "*" TechnologyAssignment

@enduml
```
