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
        XCTAssertEqual(makeController(question: .singleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithOptions() {
        XCTAssertEqual(makeController(question: .singleAnswer("Q1")).options, options)
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithSingleSelection() {
        let controller = makeController(question: .singleAnswer("Q1"))
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithQuestion() {
        XCTAssertEqual(makeController(question: .multipleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithOptions() {
        XCTAssertEqual(makeController(question: .multipleAnswer("Q1")).options, options)
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithSingleSelection() {
        let controller = makeController(question: .multipleAnswer("Q1"))
        _ = controller.view

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }

    private func makeSUT(options: [Question<String>: [String]] = [:]) -> iOSViewNavigationControllerFactory {
        return iOSViewNavigationControllerFactory(options: options)
    }

    private func makeController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in } ) as! QuestionViewController
    }
}
