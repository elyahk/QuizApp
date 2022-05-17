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
    let options: [String] = ["A1", "A2"]

    func test_questionViewController_singleAnswer_cretatesControllerWithQuestion() {
        XCTAssertEqual(makeController(question: "Q1").question, "Q1")
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithOptions() {
        XCTAssertEqual(makeController().options, options)
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithSingleSelection() {
        let controller = makeController(question: "Q1")
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    private func makeSUT(options: [Question<String>: [String]] = [:]) -> iOSViewNavigationControllerFactory {
        return iOSViewNavigationControllerFactory(options: options)
    }

    private func makeController(question: String = "") -> QuestionViewController {
        let q = Question.singleAnswer(question)
        return makeSUT(options: [q: options]).questionViewController(for: q, answerCallback: { _ in } ) as! QuestionViewController
    }
}
