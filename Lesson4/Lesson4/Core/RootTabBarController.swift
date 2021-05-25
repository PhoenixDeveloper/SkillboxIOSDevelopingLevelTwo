//
//  RootTabBarController.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = getItems()
    }

    private func getItems() -> [UIViewController] {
        return [getCurrentTasksModule(), getEndedTasksModule()]
    }
    

    private func getCurrentTasksModule() -> UIViewController {
        let currentTasksModule = CurrentTasksViewController()

        currentTasksModule.tabBarItem = UITabBarItem(title: "Текущие", image: UIImage.add, tag: 0)
        let navigationController = UINavigationController(rootViewController: currentTasksModule)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }

    private func getEndedTasksModule() -> UIViewController {
        let endedTasksModule = EndedTasksViewControllerImp()

        endedTasksModule.tabBarItem = UITabBarItem(title: "Завершенные", image: UIImage.remove, tag: 1)

        return endedTasksModule
    }
}
