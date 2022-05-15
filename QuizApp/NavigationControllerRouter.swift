//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import QuizEngine

class iOSViewNavigationControllerFactory: NavigationControllerFactory {
    private var options: [Question<String>: [String]] = [:]

    init(options: [Question<String>: [String]]) {
        self.options = options
    }

    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
        case .multipleAnswer:
            return UIViewController()
        }
    }

    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}

class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: NavigationControllerFactory

    init(_ navigationController: UINavigationController, factory: NavigationControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping AnswerCallback) {
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
    }

    func routeTo(result: Result<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
