## Synopsis

Travel Journal is result of **You Decided** lesson of **Udacity's iOS Developer Nanodegree** course.

The app allows user to add Journal based on their current location or location they chose from the FourSquare API. In addition to adding the location data, they can also add video, picture (either from user library, taken by camera or FlickR API) and notes assiociated with the location chosen. This app also implemented the use of 3D touch in order for user to peek a larger photo and also ability to view the video with the associated thumbnail. 

## Implementation 

Travel Journal has 10 view controller screens:

* Journal Table View Controller - Allow the user to add new journal; view, edit or delete current journal.

   When the user add the + button, it will present the alert asking user to type the name of the new journal. If the user didn't type anything, it will present an error message and ask the user to type the name again until something is inputed. Then it will transited to Map View Controller Scene
   
   When the user tap the name of an existing journal, it will present the alert asking if the user wanted to edit, view or delete the journal. If the user chose edit, it will allow user to change the name of the journal with the same logic as adding a new journal. If the user chose view it will transit the user to the detail journal scene. If the user chose delete, it will delete the journal from core data. 
   
* Detail Journal View Controller - Allow user to add new location; view or delete an existing location.

   If the user tap the done button, it will dismiss to the Journal Table scene. 
   
   When the user tap the add button, it will present the map view scene.
   
   When the user tap the existing location name from the table, it will present an alert where user can chose from view or delete action. With the view action, it will present the Preview View Controller. With the delete action, it will delete the location and its associated data from core data.
   
* Map View Controller - Allow user to add location based on current location or the location user tap. All location are based on fourSquare API search result.

   If the user tap the search button in the map, it will populated the data using the API based on current location
   
   If the user enter text in the text field, it will populated the data using the API based on location typed.
   
   User then chose the location name on the table and tap the next button to present the choose screen view.

* Choose Screen View Controller - User can choose between adding picture, video or notes based on the icon tapped. 

   If user tap the Preview button, it will present the preview view scene.

* Picture View Controller - Allow user to take picture, choose picture from library or choose picture from FlickR

   If user tap the Done button, it will dismiss to Choose Screen. If the camera source is not avaliable, it will present the alert controller to alert user that camera is not avaliable
   
* Picture View Collection View Controller  - Allow user to choose picture from FlickR base on the location.

   If user tap the Done button, it will dismiss to Picture View Controller

* Video View Controller - Similar to Picture View Controller, where use can take video, or choose video from library

* Text Editor View Controller - Allow user to type in their own travel experience

   When user click done, it will dismiss to Choose Scene and the notes will be saved to Core Data.
   
* Preview View Controller - Allow user to edit the notes, choose photo/video to delete, and 3D view to peek photo and video.

   When user tap the add button, it will present an alert controller, where user can choose to add picture or video. It will present the Picture view screen/Video View Screen based on action choosen.
   
   When user tap the done button, it will present the Detail Journal View
   
   When user press on Photo or video, it will present a button for user to delete one/multiple photos/videos.
   
   When user hard press on photo or video, it will present a larger view of the picture/video thrumnail using 3D touch function. The preview action allow user to delete the select photo or video. In addition, if the item is a video, it also allow user to play the video with the preview action.
   
   Keyboard will show if user tap the notes textview, and will disappear if user touch outside of the keyboard and when the keyboard dismiss, the new notes will replace the old notes in core data

* PeekView - A screen that is required by using 3D touch, it is unreachable except by using 3D touch


## Requirement 

* Xcode8
* Swift 3.0
* iOS 9 or above

## License

Copyright (c) 2017 Carl Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
