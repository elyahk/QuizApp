//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import QuizEngine

protocol NavigationControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
}
class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: NavigationControllerFactory

    init(_ navigationController: UINavigationController, factory: NavigationControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
        navigationController.pushViewController(factory.questionViewController(for: question, answerCallback: answerCallback), animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}
