import XCTest
@testable import QuizApp

class ResultViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(result: "Correct 1/2").headerLabel.text, "Correct 1/2")
    }

    func test_viewDidLoad_rendersAnswer() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer(), makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }

    // MARK: - Helpers

    private func makeSUT(result: String = "", answers: [String] = []) -> ResultViewController {
        let sut = ResultViewController(result: result, answers: answers)
        _ = sut.view

        return sut
    }

    private func makeDummyAnswer() -> String { return "A answer" }
}
