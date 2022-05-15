//
//  iOSViewNavigationControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewNavigationControllerFactoryTests: XCTestCase {
    func test_questionViewController_cretatesControllerWithQuestion() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewNavigationControllerFactory(options: [question: options])

        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in } ) as! QuestionViewController

        XCTAssertEqual(controller.question, "Q1")
    }

    func test_questionViewController_cretatesControllerWithOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewNavigationControllerFactory(options: [question: options])

        let controller = sut.questionViewController(for: question, answerCallback: { _ in } ) as! QuestionViewController

        XCTAssertEqual(controller.options, options)
    }
}
