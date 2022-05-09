//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Eldorbek on 09/05/22.
//

import UIKit

struct PresentableAnswer {
    let question: String
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    private(set) lazy var questionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(questionLabel)

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            questionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

class WrongAnswerCell: UITableViewCell {

}

final class ResultViewController: UIViewController {
    private(set) lazy var headerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
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
    private var answers = [PresentableAnswer]()

    convenience init(result: String, answers: [PresentableAnswer]) {
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
        let answer = answers[indexPath.row]
        if answer.isCorrect {
            let cell = CorrectAnswerCell()
            cell.questionLabel.text = answer.question

            return cell
        }
        
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }


}
