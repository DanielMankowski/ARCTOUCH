# ARCTOUCH
This is an example project as interview processing of ARCTOUCH company.
## Project Architecture
I have chosen RMVVM architecture to make the project, always trying to meet SOLID metodology. For that I was tried to separate responsabilities of each screen and create unit test.
## Technical Details
In order to demonstrate knowledgment I think that the most appropiate way to do the project is as native as possible, so I am going to list the components that I have used.
- For API calls: **Alamofire**. For simplicity in Network request(when dowload proyect, please do not foget to execute pod install in console).
- For download images: I have used **SDWebImage** library, added to project by CocoaPods. (when dowload proyect, please do not foget to execute pod install in console)
## Requirements
I have tried to cover all requerimients requested:
- Paging
- Search
- Movie details
- Portrait/Landscape
## Clarifications/Improvements
By time reasons in screens are missing refreshs (UIActivityIndicator) and show error messages if some error happens. By example at the moment to call API (UIAlertController).
Besides, Search Bar coud disappear when scrolling.
And so on
