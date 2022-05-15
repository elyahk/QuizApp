//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Eldorbek on 15/05/22.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTests: XCTestCase{
    func test_routeToQuestion_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }

    func test_routeToQuestionTwice_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
