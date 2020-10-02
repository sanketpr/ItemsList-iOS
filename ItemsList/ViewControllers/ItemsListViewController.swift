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

    
    private func setupTableView() {
        view.addSubview(tableView)

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

extension ItemsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceControllerDelegate.getNumberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceControllerDelegate.getNumberOfRows(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let name = dataSourceControllerDelegate.getViewModel(for: indexPath.section, at: indexPath.row).name

        cell.textLabel?.text = name
        cell.backgroundColor = dataSourceControllerDelegate.getBackgroundColor(for: indexPath.section)
        return cell
    }
}
