import XCTest
@testable import QuizApp

class QuestionViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

    func test_viewDidLoad_withOptions_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["Q1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["Q1", "Q2"]).tableView.numberOfRows(inSection: 0), 2)
    }

    func test_viewDidLoad_withOneOptions_rendersOneOptionsTexts() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1", "A2", "A3"]).tableView.title(at: 2), "A3")
    }

    func test_optionSelected_notifiesDelegate() {
        var recievedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { recievedAnswer = $0 }

        sut.tableView.select(at: 0)

        XCTAssertEqual(recievedAnswer, ["A1"])
    }

    func test_optionSelected_withTwoOptions_notifiesDelegateWithLastSelection() {
        var recievedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { recievedAnswer = $0 }

        sut.tableView.select(at: 0)
        XCTAssertEqual(recievedAnswer, ["A1"])

        sut.tableView.select(at: 1)
        XCTAssertEqual(recievedAnswer, ["A2"])
    }

    // MARK: - Helpers

    private func makeSUT(
        question: String = "",
        options: [String] = [],
        selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view

        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }

    func title(at row: Int) -> String? {
        cell(at: row)?.textLabel?.text
    }

    func select(at row: Int) {
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
}
