import Foundation

class ItemCellViewModel: ItemBaseViewModel {
    var id: Int
    var name: String

    required init(item: Item) {
        self.id = item.id
        self.name = item.name!
    }
    
    
}
