import Foundation

class ItemCellViewModel: ItemBaseViewModel {
    var id: Int
    var name: String

    required init(item: Item) {
        self.id = item.id
        self.name = item.name!
    }
    
    /// Return the `name` for cell view textlabel
    func getNameText() -> String {
        return self.name
    }
}
