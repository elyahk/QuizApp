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

        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, selection: answerCallback)
        case .multipleAnswer:
            return UIViewController()
        }
    }

    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
