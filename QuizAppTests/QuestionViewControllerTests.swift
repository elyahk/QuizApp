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

    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var recievedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isAllowsMultipleSelection: false) { recievedAnswer = $0 }

        sut.tableView.select(at: 0)
        XCTAssertEqual(recievedAnswer, ["A1"])

        sut.tableView.select(at: 1)
        XCTAssertEqual(recievedAnswer, ["A2"])
    }

    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegate() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"], isAllowsMultipleSelection: false) { _ in callbackCount += 1 }

        sut.tableView.select(at: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(callbackCount, 1)
    }

    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var recievedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isAllowsMultipleSelection: true) { recievedAnswer = $0 }

        sut.tableView.select(at: 0)
        XCTAssertEqual(recievedAnswer, ["A1"])

        sut.tableView.select(at: 1)
        XCTAssertEqual(recievedAnswer, ["A1", "A2"])
    }

    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        var recievedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isAllowsMultipleSelection: true) { recievedAnswer = $0 }

        sut.tableView.select(at: 0)
        XCTAssertEqual(recievedAnswer, ["A1"])

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(recievedAnswer, [])
    }

    // MARK: - Helpers

    private func makeSUT(
        question: String = "",
        options: [String] = [],
        isAllowsMultipleSelection: Bool = false,
        selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, isAllowsMultipleSelection: isAllowsMultipleSelection, selection: selection)
        _ = sut.view

        return sut
    }
}
