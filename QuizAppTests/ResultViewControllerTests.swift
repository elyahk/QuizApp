import XCTest
@testable import QuizApp

class ResultViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(result: "Correct 1/2").headerLabel.text, "Correct 1/2")
    }

    // MARK: - Helpers

    private func makeSUT(result: String = "") -> ResultViewController {
        let sut = ResultViewController(result: result)
        _ = sut.view

        return sut
    }
}
