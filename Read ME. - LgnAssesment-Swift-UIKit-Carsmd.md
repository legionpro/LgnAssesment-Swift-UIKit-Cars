# Read ME

## LgnAssesment-Swift-UIKit-Cars



### UI section 

It was decided to implement on UIKit without Storyboard (programmatically).. 

Possible alternatives - UIKit + storyboard or SwiftUI

The main idea for the UI is to provide max info for the user on the main screen.( two images + text info ). It needs additionally to develop "Search and Filter" functionality on the main screen



### Business Logic 

- **ItemListViewController** is the MAIN controller - list of items;
  based on MVVM: 
  ItemListModel - ItemListViewController - ItemListViewController
-  The cell view of the main list is implemented in **ItemViewCell**. 
-  The details browsing implemented in **CarouselViewController**
- ItemDataMapperProtocol is used fro the app and for **UnitTest**
-  **NetworkService** provides request to server side and get results fro the app



###  Data types :

-  **CarsListItem** - data type fro data that comes from server-side
-  **ItemDataModel** - data type that is used on UI
-  **ItemDataMapperProtocol** - is the mediator between CarsListItem and ItemDataModel



### Used APIs

Swift asyn/await + Combine + MVVM + Adapter Pattern (ItemDataMapperProtocol) + Protocol Oriented Approach + UnitTest



### Third-party APIs

Kingfisher - to load images from URL



### UnitTest

testDataMaping()  + NetworkServiceProtocol + ItemDataMapperProtocol