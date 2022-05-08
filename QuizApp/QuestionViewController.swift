import UIKit

class QuestionViewController: UIViewController {
    private(set) lazy var headerLabel: UILabel = {
        let view = UILabel()

        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self

        return view
    }()

    private var question: String = ""
    private var options: [String] = []

    convenience init(question: String, options: [String]) {
        self.init()

        self.question = question
        self.options = options
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
        return UITableViewCell()
    }


}
