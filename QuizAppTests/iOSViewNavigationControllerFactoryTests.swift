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
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    let options: [String] = ["A1", "A2"]

    func test_questionViewController_singleAnswer_cretatesControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeController(questions: [singleAnswerQuestion], question: singleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithQuestion() {
        XCTAssertEqual(makeController(question: singleAnswerQuestion).question, "Q1")
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithOptions() {
        XCTAssertEqual(makeController(question: singleAnswerQuestion).options, options)
    }

    func test_questionViewController_singleAnswer_cretatesControllerWithSingleSelection() {
        let controller = makeController(question: singleAnswerQuestion)
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithTitle() {
        XCTAssertEqual(makeController(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion).title, "Question #2")
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithQuestion() {
        XCTAssertEqual(makeController(question: multipleAnswerQuestion).question, "Q2")
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithOptions() {
        XCTAssertEqual(makeController(question: multipleAnswerQuestion).options, options)
    }

    func test_questionViewController_multipleAnswer_cretatesControllerWithSingleSelection() {
        let controller = makeController(question: multipleAnswerQuestion)
        _ = controller.view

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }

    private func makeSUT(questions: [Question<String>] = [], options: [Question<String>: [String]] = [:]) -> iOSViewNavigationControllerFactory {
        return iOSViewNavigationControllerFactory(questions: questions, options: options)
    }

    private func makeController(questions: [Question<String>] = [], question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(questions: questions, options: [question: options]).questionViewController(for: question, answerCallback: { _ in } ) as! QuestionViewController
    }
}
