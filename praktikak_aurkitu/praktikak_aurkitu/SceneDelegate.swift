import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply that the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system. (Appelée lorsque la scène est libérée par le système.)
        // This occurs shortly after the scene enters the background, or when its session is discarded. (Cela se produit peu après que la scène passe en arrière-plan, ou lorsque sa session est ignorée.)
        // Release any resources associated with this scene that can be re-created the next time the scene connects. (Libérez toutes les ressources associées à cette scène qui peuvent être recréées lors de la prochaine connexion de la scène.)
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead). (La scène peut se reconnecter plus tard, car sa session n'a pas nécessairement été ignorée.)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state. (Appelée lorsque la scène est passée d'un état inactif à un état actif.)
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive. (Utilisez cette méthode pour redémarrer toutes les tâches qui ont été mises en pause (ou non encore démarrées) lorsque la scène était inactive.)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state. (Appelée lorsque la scène passera d'un état actif à un état inactif.)
        // This may occur due to temporary interruptions (ex. an incoming phone call). (Cela peut se produire en raison d'interruptions temporaires (par exemple, un appel téléphonique entrant).)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground. (Appelée lorsque la scène passe de l'arrière-plan au premier plan.)
        // Use this method to undo the changes made on entering the background. (Utilisez cette méthode pour annuler les modifications apportées lors de l'entrée en arrière-plan.)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background. (Appelée lorsque la scène passe du premier plan à l'arrière-plan.)
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state. (Utilisez cette méthode pour enregistrer les données, libérer les ressources partagées et stocker suffisamment d'informations d'état spécifiques à la scène pour restaurer la scène à son état actuel.)
    }


}
