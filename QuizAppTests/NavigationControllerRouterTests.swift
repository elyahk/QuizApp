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
        let factory = NavigationControlllerFactoryStub()
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        let viewController = UIViewController()
        factory.stub(for: "Q1", with: viewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    func test_routeToSecondQuestion_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let factory = NavigationControlllerFactoryStub()
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(for: "Q1", with: viewController)
        factory.stub(for: "Q2", with: secondViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController, secondViewController])
    }

    func test_routeToQuestion_presentsQuestionViewControllerWithRightCallback() {
        let navigationController = UINavigationController()
        let factory = NavigationControlllerFactoryStub()
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        let viewController = UIViewController()

        var callbackWasFired = false
        factory.stub(for: "Q1", with: viewController)
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback["Q1"]!("anything")

        XCTAssertTrue(callbackWasFired)
    }

    class NavigationControlllerFactoryStub: NavigationControllerFactory {
        var stub = [String: UIViewController]()
        var answerCallback: [String: (String) -> Void] = [:]

        func stub(for question: String, with viewController: UIViewController) {
            stub[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stub[question] ?? UIViewController()
        }
    }
}
