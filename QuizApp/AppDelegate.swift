import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = QuestionViewController(question: "A question?", options: ["A1", "A2"]) { print($0) }
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}

