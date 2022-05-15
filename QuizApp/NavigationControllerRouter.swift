//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import QuizEngine

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value):
            hasher.combine(value)
        case .multipleAnswer(let value):
            hasher.combine(value)
        }
    }
}

protocol NavigationControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
}
class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: NavigationControllerFactory

    init(_ navigationController: UINavigationController, factory: NavigationControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping AnswerCallback) {
        navigationController.pushViewController(factory.questionViewController(for: question, answerCallback: answerCallback), animated: false)
    }

    func routeTo(result: Result<Question<String>, String>) {

    }
}
