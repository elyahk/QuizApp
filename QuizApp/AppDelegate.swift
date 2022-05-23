import UIKit
import QuizEngine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        let question1 = Question.singleAnswer("What is my current position?")
        let question2 = Question.multipleAnswer("What type of language I use for building iOS app?")
        let questions = [question1, question2]

        let option1_1 = "Engineer 1"
        let option1_2 = "Engineer 2"
        let option1_3 = "Engineer 3"
        let options1 = [option1_1, option1_2, option1_3]

        let option2_1 = "Swift"
        let option2_2 = "Objective C"
        let option2_3 = "Python"
        let options2 = [option2_1, option2_2, option2_3]

        let options = [question1: options1, question2: options2]
        let correctAnswers = [question1: [option1_1], question2: [option2_1, option2_2]]

        let factory = iOSViewNavigationControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
        let navigationRouter = NavigationControllerRouter(navigationController, factory: factory)

        game = startGame(questions: questions, router: navigationRouter, answers: correctAnswers)
        
        self.window = window
        self.window?.rootViewController = navigationController
        window.makeKeyAndVisible()

        return true
    }
}

