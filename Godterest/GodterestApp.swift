//
//  GodterestApp.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                guard granted else { return }

               // application.registerForRemoteNotifications()
            }
           
        //}
        
      
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
           sceneConfig.delegateClass = SceneDelegate.self
           return sceneConfig
       }
    
    func applicationDidBecomeActive(_ application: UIApplication){
       
    }
    
    func application(_ application:UIApplication, didRegisterForRemoteNotificationsWithDeviceToken devicetoken: Data) {
        let token = devicetoken.map { String(format: "%02.2hhx", $0) }.joined()
           print(token)
            
        QuestionsVM.Shared.deviceToken = token
        
      
     }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

        print("i am not available in simulator :( \(error)")
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}


@main
struct GodterestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @State var ColorschemeViewModel = ColorSchemeVM()
  @State var CreateAccountViewModel = QuestionsVM()
  @State var loginViewModel = LoginVM()
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            ContentView()
                  .environment(\.isLoggedIn, false)
          }
          .environmentObject(ColorschemeViewModel)
          .environmentObject(CreateAccountViewModel) 
          .environmentObject(loginViewModel)
        }
    }
  
    
}
