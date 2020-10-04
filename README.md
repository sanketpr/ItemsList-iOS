# ItemsList iOS

##### Submission by:
##### Name: Sanket Kulthe
##### Email: sanketpr@buffalo.edu
##### LinkedIn: https://www.linkedin.com/in/sanket-kulthe/


#### Design Choice:

- I initially approached this task with MVC architecture because
	1. This would give me three entities with dedicated responsiblities
	2. Since the application was not too large, MVC would keep things relatively simpler
	3. Also it was easy to implement
- However there are some drawback of using this architecture, for instance there is strong couping of functionalities.
- View controller would have more than one responsiblities,
	1. Being responsilbe for presenting the list of items.
	2. Managing data conversion and data flow between model and view
  This does not confirm to Single Responsiblity Principle and especially View Controller would become a bit more complex.
- Also because of this the ViewController can get flooded with different functionalities and therefore becomes difficult to test
- Even though MVVM can be thought of as too much for this assignment, but because of MVVM each class has one responsiblities and there is proper seperation of concern.
- Because of this quality the classes will be smaller in size and also would be easy to test
- Also using this architecture gives us more flexiblity to substitute components which is good for scaling the application.
- Morover while implementing I enforced the use of Protocols in places to ensures that the classes are open to extension without the need to modify them, conforming to Open-Closed Principle
- At any point if there is any need to add more functionality we can simply provide a new implementation because of which
we won't have to change any code that is using that functionality.


#### Structure:

![Class Diagram](https://raw.githubusercontent.com/sanketpr/ItemsList-iOS/main/ClassDiagram.jpg)

##### `ItemsListViewController`:
- ItemsListViewController is the entry point to the application. It maintains a UITableView for presenting a list of items
- This View Controller maintains a Data Source Delegate with the help of which it configures the TableView

##### `DataSourceControllerDelegate`:
- The `RootViewController` uses this Protocol as the Data Source delegate for the TableView
- This class fetches list of items using `NetworkHandler` and translates it to an array of `ViewModels`

##### `ItemsListDataSourceDelegate`:
- This view controller implements `DataSourceControllerDelegate`.
- This class uses a dictionary with key as the section number and value as an array of `ViewModels` of items in that section

##### `NetworkHandler`:
- This class is responsible for fetching list items from the given end point and translate it into a `Model`

##### `Item`:
- This class corresponds to the server side model of an `Item`

##### `ItemBaseViewModel`:
- This Protocol guides the translation of `Item` Model to a ViewModel i.e. It translates the data from a `Model` and make it more 
usable for the View (that in this case is a TableViewCell)
- The `getName()` method can have different implementations. 
  Like:
  a. It can return simply the name of the item
  b. It can return a string appending Id and Name of the item
      and more such

##### `ItemCellViewModel`:
- This class implements `ItemBaseViewModel`. This class implements getName() such that it returns the `name` property of the item 
