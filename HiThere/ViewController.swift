//
//  ViewController.swift
//  HiThere
//
//  Created by Александр Кириченко on 09.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание Navigation Bar и фрейма, в котором разместим Label "Chats"
        if let navigationBar = self.navigationController?.navigationBar{
            let labelFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width, height: navigationBar.frame.height)
            
            //Создание Label "Chats" и настройка его параметров
            let chatsLabel = UILabel(frame: labelFrame)
            chatsLabel.text = "Chats"
            chatsLabel.textAlignment = .center
            
            //Отображение Label на View
            navigationBar.addSubview(chatsLabel)
        }
        
       // Создание кнопки "Edit" в Navigation Bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        }

        func handleLogout(){
            let loginController = LoginController()
            present(loginController, animated: true, completion: nil)
    }
    
    

}

