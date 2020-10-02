import UIKit

/// This class is the datasource delegate for the ItemsListViewController

class ItemsListDataSourceController: DataSourceControllerDelegate {

    private let backgroundColors: [UIColor] = [.white, .yellow, .cyan, .brown, .red, .systemBlue]
    private var itemViewModels = [Int:[ItemBaseViewModel]]()
    private var dataBindingCompletion: () -> ()

    required init(network: NetworkRequestHandler, dataBindingCompletion: @escaping ()->()) {
        self.dataBindingCompletion = dataBindingCompletion
        network.fetchItemsList(completion: populateItemViewModelsList(items:))
    }

    private func populateItemViewModelsList(items: [Item?]){
        for item in items {
            if let item = item {
                if let _ = itemViewModels[item.listId] {
                    itemViewModels[item.listId]?.append(ItemCellViewModel(item: item))
                } else {
                    itemViewModels[item.listId] = [ItemCellViewModel(item: item)]
                }
            }
        }

        sortViewModelsByName()
        dataBindingCompletion()
    }

    private func sortViewModelsByName() {
        for key in itemViewModels.keys {
            itemViewModels[key] = itemViewModels[key]!.sorted(by: {$0.name.compare($1.name, options: .numeric) == .orderedAscending})
        }
    }

    func getNumberOfSections() -> Int {
        return itemViewModels.count
    }

    func getNumberOfRows(for section: Int) -> Int {
        return itemViewModels[section]?.count ?? 0
    }

    func getViewModel(for section: Int, at row: Int) -> ItemBaseViewModel {
        return (itemViewModels[section]?[row])!
    }

    func getBackgroundColor(for section: Int) -> UIColor {
        let colorCount = backgroundColors.count
        return backgroundColors[section%colorCount]
    }
}
