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
        view.backgroundColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0

        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.register(CorrectAnswerCell.self)
        view.register(WrongAnswerCell.self)
        view.backgroundColor = .systemGray5

        return view
    }()

    private(set) var summary = ""
    private(set) var presentableAnswers = [PresentableAnswer]()
    private let correctAnswerCellIdentifier = "CorrectAnswerCell"
    private let wrongAnswerCellIdentifier = "WrongAnswerCell"

    convenience init(summary: String, presentableAnswers: [PresentableAnswer]) {
        self.init()

        self.summary = summary
        self.presentableAnswers = presentableAnswers
    }

    override func loadView() {
        super.loadView()

        headerLabel.text = summary
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
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
        return presentableAnswers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = presentableAnswers[indexPath.row]

        return answer.wrongAnswer == nil ? correctAnswerCell(for: answer) : wrongAnswerCell(for: answer)
    }

    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self) else {
            return CorrectAnswerCell()
        }

        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer

        return cell
    }

    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(WrongAnswerCell.self) else {
            return WrongAnswerCell()
        }

        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer

        return cell
    }
}

