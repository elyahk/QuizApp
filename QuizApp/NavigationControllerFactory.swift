//
//  File.swift
//  QuizEngine
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import QuizEngine

protocol NavigationControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController

    func resultViewController(for result: Result<Question<String>, String>) -> UIViewController
}
