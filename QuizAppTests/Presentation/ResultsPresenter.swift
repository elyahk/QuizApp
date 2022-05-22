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
    let singleAnswer = Question.singleAnswer("Q1")
    let multipleAnswer = Question.multipleAnswer("Q2")

    func test_title_returnsFormattedTitle() {
        let result: Result<Question<String>, [String]> = Result(answers: [:], score: 0)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])

        XCTAssertEqual(sut.title, "Result")
    }

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [singleAnswer: ["A1"], multipleAnswer: ["A2", "A3"]]
        let result = Result(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, questions: [singleAnswer, multipleAnswer], correctAnswers: [:])

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])

        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }

    func test_presentableAnswers_withWrongSinleAnswer_mapsAnswer() {
        let answers = [singleAnswer: ["A1"]]
        let correctAnswers = [singleAnswer: ["A2"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [Question.singleAnswer("Q1")], correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }

    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [multipleAnswer: ["A1", "A3"]]
        let correctAnswers = [multipleAnswer: ["A2", "A4"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [multipleAnswer], correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A4")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A3")
    }

    func test_presentableAnswers_withRightSinleAnswer_mapsAnswer() {
        let answers = [singleAnswer: ["A1"]]
        let correctAnswers = [singleAnswer: ["A1"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [singleAnswer], correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }

    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [multipleAnswer: ["A1", "A3"]]
        let correctAnswers = [multipleAnswer: ["A1", "A3"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [multipleAnswer], correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A3")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }

    func test_presentableAnswers_orderedQuestions_mapsOrderedQuestionAnswers() {
        let questions = [singleAnswer, multipleAnswer]
        let answers = [singleAnswer: ["A1"], multipleAnswer: ["A1", "A3"]]
        let correctAnswers = [singleAnswer: ["A1"], multipleAnswer: ["A1", "A3"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A3")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
}
