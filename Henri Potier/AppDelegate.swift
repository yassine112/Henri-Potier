//
//  AppDelegate.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 14/4/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let booksListVC = storyboard.instantiateViewController(withIdentifier: "BooksListViewController") as? BooksListViewController {
            // Dependencies Injection
            let presenter = BooksListPresenter(viewController: booksListVC)
            let interactor = BooksListInteractor(presenter: presenter)
            booksListVC.interactor = interactor
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UINavigationController(rootViewController: booksListVC)
            window?.makeKeyAndVisible()
        }
        
        return true
    }


}

