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
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    var factory = NavigationControlllerFactoryStub()
    fileprivate var navigationController = NonAnimatedNavigationController()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        factory.stub(for: singleAnswerQuestion, with: viewController)

        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    func test_routeToSecondQuestion_presentsQuestionViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(for: singleAnswerQuestion, with: viewController)
        factory.stub(for: multipleAnswerQuestion, with: secondViewController)

        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [viewController, secondViewController])
    }

    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[singleAnswerQuestion]!(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToQuestion_singleAnswer_doesNotConfigureViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(for: singleAnswerQuestion, with: viewController)

        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressesToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])

        XCTAssertFalse(callbackWasFired)
    }

    func test_routeToQuestion_multipleAnswer_configureViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(for: multipleAnswerQuestion, with: viewController)

        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswer_configureButtonEnableAndDisableBySelectedAnswerCount() {
        let viewController = UIViewController()
        factory.stub(for: multipleAnswerQuestion, with: viewController)

        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_progressToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(for: multipleAnswerQuestion, with: viewController)

        var callBackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callBackWasFired = true })

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        let button = viewController.navigationItem.rightBarButtonItem!
        button.simulateTap()

        XCTAssertTrue(button.isEnabled)
        XCTAssertTrue(callBackWasFired)
    }

    func test_routeToResult_showsResultViewController() {
        let result = Result(answers: [singleAnswerQuestion: ["A1"]], score: 1)
        let viewController = UIViewController()
        factory.stub(result: result, with: viewController)
        sut.routeTo(result: result)

        XCTAssertEqual(navigationController.viewControllers, [viewController])
    }

    // MARK: - Helpers

    final class NavigationControlllerFactoryStub: ViewControllerFactory {
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


private extension UIBarButtonItem {
    func simulateTap() {
        target?.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
