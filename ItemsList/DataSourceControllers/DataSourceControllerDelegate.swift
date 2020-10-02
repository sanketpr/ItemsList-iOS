import UIKit


/// This delegate is responsible for maintaining data that the tableview should use to obtain
/// for sepcific section and row

protocol DataSourceControllerDelegate {
    init(network: NetworkRequestHandler, dataBindingCompletion: @escaping () -> ())
    func getNumberOfSections() -> Int
    func getNumberOfRows(for section: Int) -> Int
    func getViewModel(for section: Int, at row: Int) -> ItemBaseViewModel
    func getBackgroundColor(for section: Int) -> UIColor
}
