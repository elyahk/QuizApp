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

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}
