import UIKit

class QuestionViewController: UIViewController {
    private(set) lazy var headerLabel: UILabel = {
        let view = UILabel()

        return view
    }()

    private var question: String = ""

    convenience init(question: String) {
        self.init()

        self.question = question
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
    }
}
