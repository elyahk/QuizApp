//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping AnswerCallback) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: answerCallback))

        case .multipleAnswer:
            let controller = factory.questionViewController(for: question, answerCallback: { _ in })
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }

    func routeTo(result: Result<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
