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

    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: true)])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }

    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "A2", isCorrect: false)])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "A2")
    }

    func test_viewDidLoad_withWrongtAnswer_rendersWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(isCorrect: false)])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
    }

    // MARK: - Helpers

    private func makeSUT(result: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(result: result, answers: answers)
        _ = sut.view

        return sut
    }

    private func makeDummyAnswer() -> PresentableAnswer { return makeAnswer(isCorrect: false) }

    private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil, isCorrect: Bool) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer, isCorrect: isCorrect)
    }
}
