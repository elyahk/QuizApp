//
//  QuestionPresenterTests.swift
//  QuizApp
//
//  Created by Eldorbek on 21/05/22.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionPresenterTests: XCTestCase {
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let question1 = Question.singleAnswer("Q1")
        let questions = [question1]
        let sut = QuestionPresenter(questions: questions, question: question1)

        XCTAssertEqual(sut.title, "Question #1")
    }

    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let question1 = Question.singleAnswer("Q1")
        let question2 = Question.multipleAnswer("Q2")
        let questions = [question1, question2]

        let sut = QuestionPresenter(questions: questions, question: question2)

        XCTAssertEqual(sut.title, "Question #2")
    }

    func test_title_forUnexistenceQuestion_isEmpty() {
        let question1 = Question.singleAnswer("Q1")
        let question2 = Question.multipleAnswer("Q2")
        let question3 = Question.singleAnswer("Q3")
        let questions = [question1, question2]

        let sut = QuestionPresenter(questions: questions, question: question3)

        XCTAssertEqual(sut.title, "")
    }
}
