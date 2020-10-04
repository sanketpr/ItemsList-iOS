import UIKit


/// The root view controller and the main entry point into the appliation
/// This maintains a table view which displays list of items with the help of data source controller

class ItemsListViewController: UIViewController, UITableViewDelegate {

    let tableView = UITableView()
    private let cellReuseIdentifier = "CELL_ID"
    private var safeArea: UILayoutGuide!

    private var dataSourceControllerDelegate: DataSourceControllerDelegate!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide

        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let networkReqHandler = NetworkRequestHandler()
        dataSourceControllerDelegate = ItemsListDataSourceController(network: networkReqHandler) { [weak self] in
            if let self = self {
                self.tableView.reloadData()
            }
        }
    }

    /// Adding a table view to the view and setting it's constraints to match
    private func setupTableView() {
        view.addSubview(tableView)

        // TODO: Remove the safe area constraint. The issue with the clipped view seems to be iOS 14 specific
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

/// UITableView DataSource Methods
extension ItemsListViewController: UITableViewDataSource {

    // Deselect the selected cell with animation on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Determine the number of sections/categories we have in the datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceControllerDelegate.getNumberOfSections()
    }

    // Determine the number of rows in a particular section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceControllerDelegate.getNumberOfRows(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let viewModel = dataSourceControllerDelegate.getViewModel(for: indexPath.section, at: indexPath.row)
        cell.textLabel?.text = viewModel.getNameText()
        cell.backgroundColor = dataSourceControllerDelegate.getBackgroundColor(for: indexPath.section)
        return cell
    }
}
