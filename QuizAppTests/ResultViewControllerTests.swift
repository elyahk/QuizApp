import XCTest
@testable import QuizApp

class ResultViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(result: "Correct 1/2").headerLabel.text, "Correct 1/2")
    }

    func test_viewDidLoad_withoutAnswers_doesNotRendersAnswers() {
        let sut = makeSUT(answers: [])

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_withOneAnswers_rendersOneAnswer() {
        let sut = makeSUT(answers: ["A1"])

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    // MARK: - Helpers

    private func makeSUT(result: String = "", answers: [String] = []) -> ResultViewController {
        let sut = ResultViewController(result: result, answers: answers)
        _ = sut.view

        return sut
    }
}
