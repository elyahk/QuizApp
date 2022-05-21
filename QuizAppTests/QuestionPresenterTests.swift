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
        let questions = [Question.singleAnswer("Q1"), Question.multipleAnswer("Q2"), ]
        let question = Question.singleAnswer("Q1")
        let sut = QuestionPresenter(questions: questions, question: question)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
}
