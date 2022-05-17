//
//  File.swift
//  QuizApp
//
//  Created by Eldorbek on 17/05/22.
//

import UIKit
import QuizEngine

class iOSViewNavigationControllerFactory: ViewControllerFactory {
    private var options: [Question<String>: [String]] = [:]

    init(options: [Question<String>: [String]]) {
        self.options = options
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
            return QuestionViewController(question: value, options: options, selection: answerCallback)

        case .multipleAnswer(let value):
            let controller = QuestionViewController(question: value, options: options, selection: answerCallback)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true

            return controller
        }
    }

    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
