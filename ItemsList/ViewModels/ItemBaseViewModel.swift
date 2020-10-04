import Foundation

protocol ItemBaseViewModel {

    var id: Int { get }
    var name: String { get }

    init(item: Item)
    func getNameText() -> String
}
