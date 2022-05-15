//
//  QuestionTests.swift
//  QuizApp
//
//  Created by Eldorbek on 15/05/22.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionTests: XCTestCase {
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a string"
        let sut = Question.singleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }

    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "a string"
        let sut = Question.multipleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }

}
