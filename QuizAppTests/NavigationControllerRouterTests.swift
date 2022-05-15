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
    var navigationController = UINavigationController()
    var factory = NavigationControlllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        factory.stub(for: "Q1", with: viewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    func test_routeToSecondQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(for: "Q1", with: viewController)
        factory.stub(for: "Q2", with: secondViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController, secondViewController])
    }

    func test_routeToQuestion_presentsQuestionViewControllerWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback["Q1"]!("anything")

        XCTAssertTrue(callbackWasFired)
    }

    // MARK: - Helpers

    final class NavigationControlllerFactoryStub: NavigationControllerFactory {
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
