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
    var factory = NavigationControlllerFactoryStub()
    fileprivate var navigationController = NonAnimatedNavigationController()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        factory.stub(for: Question.singleAnswer("Q1"), with: viewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    func test_routeToSecondQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(for: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(for: Question.singleAnswer("Q2"), with: secondViewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController, secondViewController])
    }

    func test_routeToQuestion_presentsQuestionViewControllerWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[.singleAnswer("Q1")]!(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToResult_showsResultViewController() {
        let result = Result(answers: [Question.singleAnswer("a string"): ["A1"]], score: 1)
        let viewController = UIViewController()
        factory.stub(result: result, with: viewController)
        sut.routeTo(result: result)

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    // MARK: - Helpers

    final class NavigationControlllerFactoryStub: NavigationControllerFactory {
        var stubedQuestions = [Question<String>: UIViewController]()
        var stubedResults = [Result<Question<String>, [String]>: UIViewController]()
        var answerCallback: [Question<String>: ([String]) -> Void] = [:]

        func stub(for question: Question<String>, with viewController: UIViewController) {
            stubedQuestions[question] = viewController
        }

        func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
            stubedResults[result] = viewController
        }

        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubedQuestions[question] ?? UIViewController()
        }

        func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return stubedResults[result]!
        }

    }
}

extension Result: Hashable {
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }
}

private class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}
