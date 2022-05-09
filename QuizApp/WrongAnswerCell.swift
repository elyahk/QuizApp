//
//  File.swift
//  QuizApp
//
//  Created by Eldorbek on 09/05/22.
//

import UIKit

class WrongAnswerCell: UITableViewCell {
    private(set) lazy var questionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black

        return view
    }()

    private(set) lazy var correctAnswerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black

        return view
    }()

    private(set) lazy var wrongAnswerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black

        return view
    }()

    private(set) lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [questionLabel, correctAnswerLabel, wrongAnswerLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 4.0
        view.axis = .vertical

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
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
