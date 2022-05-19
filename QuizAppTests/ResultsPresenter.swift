//
//  ResultsPresenter.swift
//  QuizAppTests
//
//  Created by Eldorbek on 19/05/22.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTests: XCTestCase {
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result)

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_empty_shouldBeEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result)

        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
}
