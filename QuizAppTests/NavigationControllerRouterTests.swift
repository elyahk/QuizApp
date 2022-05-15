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

        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }

    class NavigationControlllerFactoryStub: NavigationControllerFactory {
        var stub = [String: UIViewController]()

        func stub(for question: String, with viewController: UIViewController) {
            stub[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: (String) -> Void) -> UIViewController {
            return stub[question]!
        }
    }
}
