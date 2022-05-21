//
//  File.swift
//  QuizApp
//
//  Created by Eldorbek on 17/05/22.
//

import UIKit
import QuizEngine

class iOSViewNavigationControllerFactory: ViewControllerFactory {
    private let questions: [Question<String>]
    private var options: [Question<String>: [String]]

    init(questions: [Question<String>], options: [Question<String>: [String]]) {
        self.options = options
        self.questions = questions
    }

    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }

    private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(
                   for: question,
                   value: value,
                   options: options,
                   isAllowsMultipleSelection: false,
                   answerCallback: answerCallback
            )

        case .multipleAnswer(let value):
            let controller = questionViewController(for: question, value: value, options: options, isAllowsMultipleSelection: true, answerCallback: answerCallback)

            return controller
        }
    }

    private func questionViewController(
        for question: Question<String>,
        value: String,
        options: [String],
        isAllowsMultipleSelection: Bool = false,
        answerCallback: @escaping ([String]) -> Void
    ) -> QuestionViewController {
        let presenter  = QuestionPresenter(questions: questions, question: question)
        let controller =  QuestionViewController(
            question: value,
            options: options,
            isAllowsMultipleSelection: isAllowsMultipleSelection,
            selection: answerCallback
        )
        controller.title = presenter.title

        return controller
    }

    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
