# MyChessApp
 
 A few things to mention about this project:
 
// I have tried to display 2 different types of architecture

1) MVVM:

- I created the base class ChessTableViewController which has the intention/potential for all other  VC's to inherit from it.

- The main Idea is that we use a table view which is rendered in the base class in order for suclasses to just create cells to accustom their UI accordingly and create re-usable components and an easy setting for our new VC's which can save a lot of time. 

The goal is to create UI elements as generic as possible in order for it to be used whenever it is needed even with a different configuration,and that let the base class handle the datasource and the delegate and the rendering of the tableview having to write this only once.

- The second part of this architecture is located in the base classes ChessTableViewCell and ChessTableViewCellModel
the architectire is based in the following logic: 
-all cells must inherit from ChessTableViewCell. Any common logic must be applied there. The cells are responsible for the UI presentation of a cell. and any ui update/change.

-all cells must have a cellModel in order to implement the business logic there. Common fuctionality is placed at the base class of ChessTableViewCellModel. I have created 2 protocols to display this inheritance and it's advantages. The updateView method which is common for all cells model adjusts the UI (via the cell) in coordinance with the data and the business logic.

WelcomeVC and ResultPathsVC display this architecture in full.

2) a "hubrid" of MVC and VIP:

for the collectionView controller: ChessCollectionViewController I have created a more "traditional" controller in accordance with the MVC norm.
However the full functionality of the chess to get the available paths (algorithm and logic was found online) is handled by a Chess Service.

this complies with the logic of VIP and has the role of the Interactor because it contains all the business logic and is called upon to make results.

I did not go full VIP (create a Presenter to change the UI or a coordinator to handle the flow) because it would not interact well with the MVVM and I would not avoid over-engineering (beyond the point I purosely over-engineer in order to display some architectural knowledge). 

The "traditional" handling of the data and the delegate and datasource methods of the collection View is made by the VC. However a "touch" of VIP is displayed with the Chess Service which is instantiated and maintained by the VC however it implements the full chess logic by conforming to a protocol in order to set the rules, and informs the VC for any UI changes that need to be done.

Finally the logic applied in the Chess Service Protocol methods implementation in order to produce results is an algorithm found online that solves the task.
