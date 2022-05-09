import UIKit

class QuestionViewController: UIViewController {
    private(set) lazy var headerLabel: UILabel = {
        let view = UILabel()

        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self

        return view
    }()

    private var question = ""
    private var options = [String]()
    private var selection: (([String]) -> Void)? = nil
    private let reuseIdentifier = "Cell"

    convenience init(question: String, options: [String], selection: @escaping ([String]) -> Void) {
        self.init()

        self.question = question
        self.options = options
        self.selection = selection
    }

    override func loadView() {
        super.loadView()

        view.addSubview(headerLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 44.0),

            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]

        return cell
    }

    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }

        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }

}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }

    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return indexPaths.map { options[$0.row] }
    }
}
