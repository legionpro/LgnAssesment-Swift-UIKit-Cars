# Read ME

## LgnAssesment-Swift-UIKit-Cars

### The Task :

....be able to browse used cars on an app, with enough information  to decide which one is best.....please don’t spend more than 4 hours on the task....

### **EndPoint**:

https://private-fe87c-simpleclassifieds.apiary-mock.com

~~~json
[
    {
        "id": 1,
        "make": "BMW",
        "model": "316i",
        "price": 13000,
        "firstRegistration": "01-2000",
        "mileage": 25000,
        "fuel": "Gasoline",
        "images": [
            {
                "url": "https://loremflickr.com/g/320/240/bmw"
            },
            {
                "url": "https://loremflickr.com/g/640/480/bmw"
            },
            {
                "url": "https://loremflickr.com/g/1600/1200/bmw"
            }
        ],
        "description": "Almost like new. Full service history"
    },
    {
        "id": 2,
        "make": "Audi",
        "model": "A8",
        "fuel": "Gasoline",
        "modelline": "quattro",
        "price": 16000,
        "firstRegistration": "02-2008",
        "mileage": 0,
        "seller": {
            "type": "Private",
            "phone": "+123456789",
            "city": "MÃ¼nchen"
            },
        "description": "No description available."
    },
    {
        "id": 3,
        "make": "Audi",
        "model": "A7",
        "price": 20000,
        "mileage": 0,
        "fuel": "Gasoline",
        "seller": {
            "type": "Dealer",
            "phone": "+123456789",
            "city": "Stuttgart"
            },
         "images": [
            {
                "url": "https://loremflickr.com/g/480/640/audi"
            },
            {
                "url": "https://loremflickr.com/g/1600/1200/audi"
            },
            {
                "url": "https://loremflickr.com/g/640/480/audi"
            },
            {
                "url": "https://loremflickr.com/g/640/480/audi"
            },
            {
                "url": "https://loremflickr.com/g/480/640/audi"
            }
        ],
        "description": "Good condition, had an accident two years ago."
    },
     {
        "id": 4,
        "make": "Ford",
        "model": "Mondeo",
        "colour": "White",
        "price": 5000,
        "mileage": 250000,
        "fuel": "Diesel",
        "seller": {
            "type": "Private",
            "phone": "+123456789",
            "city": "Rosenheim"
            },
         "images": [
            {
                "url": "https://loremflickr.com/g/480/640/ford"
            },
            {
                "url": "https://loremflickr.com/g/1200/1600/ford"
            },
            {
                "url": "https://loremflickr.com/g/640/480/ford"
            },
            {
                "url": "https://loremflickr.com/g/640/480/ford"
            },
            {
                "url": "https://loremflickr.com/g/480/640/ford"
            }
        ],
        "description": "Engine replaced at 180000km."
    },
     {
        "id": 5,
        "make": "Porsche",
        "model": "911",
        "colour": "Brown",
        "price": 100000,
        "mileage": 4500,
        "fuel": "Gasoline",
        "seller": {
            "type": "Private",
            "phone": "+123456789",
            "city": "KÃ¶ln"
            },
         "images": [
            {
                "url": "https://loremflickr.com/g/480/640/porsche"
            },
            {
                "url": "https://loremflickr.com/g/1200/1600/porsche"
            },
            {
                "url": "https://loremflickr.com/g/480/640/porsche"
            }
        ],
        "description": "Engine replaced at 180000km."
    }

]

~~~





### UI section 

It was decided to implement on UIKit without Storyboard (programmatically).. 

Possible alternatives - UIKit + storyboard or SwiftUI

The main idea for the UI is to provide max info for the user on the main screen.( two images + text info ). It needs additionally to develop "Search and Filter" functionality on the main screen



### Business Logic 

- **ItemListViewController** is the MAIN controller - list of items;
  based on MVVM: 
  ItemListModel - ItemListViewController - ItemListViewController
- The cell view of the main list is implemented in **ItemViewCell**. 
- The details browsing implemented in **CarouselViewController**
- ItemDataMapperProtocol is used fro the app and for **UnitTest**
- **NetworkService** provides request to server side and get results fro the app



###  Data types :

-  **CarsListItem** - data type fro data that comes from server-side
-  **ItemDataModel** - data type that is used on UI
-  **ItemDataMapperProtocol** - is the mediator between CarsListItem and ItemDataModel



### Used APIs

UICollectionViewDiffableDataSource + Swift asyn/await + Combine + MVVM + Adapter Pattern (ItemDataMapperProtocol) + Protocol Oriented Approach + UnitTest



### Third-party APIs

Kingfisher - to load images from URL



### UnitTest

testDataMaping()  + NetworkServiceProtocol + ItemDataMapperProtocol

