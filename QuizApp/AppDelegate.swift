import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ResultViewController(result: "You got 1/2 correct", answers: [
            PresentableAnswer(question: "A quesiton? A quesiton? A quesiton? A quesiton? A quesiton? A quesiton?", answer: "a answer a answer a answer a answer a answer a answer a answer", wrongAnswer: nil),
            PresentableAnswer(question: "Another question?", answer: "Hell yeah!", wrongAnswer: "Hell no!")
        ])
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}

