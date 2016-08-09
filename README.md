# YourHomeStuff

This is a small app called YourHomeStuff written in swift 3 using Xcode 8 beta. You can add items to the tableview and update the name, serial, and value for the row. 
Currently when adding a row it is generating a random adjective and noun inside the `Item.swift` model. 

The `ImageStore` file is handling the caching of the images.
`ItemStore` has three main functions for adding, retriving, and deleting the image with the corresponding key
``` 
setImage
imageForKey
deleteImageForKey
imageURLForKey
```

The `Item` is also using `NSCoding` so look at that to see an example of setting up a object model for NSCoding. 

##WalkThrough
![Walkthrough](https://cloud.githubusercontent.com/assets/6208036/17531781/08f73e56-5e43-11e6-90ae-9491dee443d7.gif)
