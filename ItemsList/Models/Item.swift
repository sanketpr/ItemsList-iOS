import Foundation

class Item {
    var id: Int!
    var listId: Int!
    var  name: String?
    
    init?(dictionary: JSONDict) {
        guard let id = dictionary["id"] as? Int,
              let name = dictionary["name"] as? String, name.count > 0,
              let listId = dictionary["listId"] as? Int else {
            return nil
        }

        self.id = id
        self.listId = listId
        self.name = name
    }
}
