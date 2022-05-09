//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Eldorbek on 09/05/22.
//

import UIKit

final class ResultViewController: UIViewController {
    private(set) lazy var headerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Test"
        view.textAlignment = .center

        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.backgroundColor = .systemGray5

        return view
    }()

    private var result = ""
    private var answers = [String]()

    convenience init(result: String, answers: [String]) {
        self.init()

        self.result = result
        self.answers = answers
    }

    override func loadView() {
        super.loadView()

        headerLabel.text = result
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 44.0),

            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
