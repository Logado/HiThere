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
        
        // Создание Navigation Bar и создание Title "Chats"
        if let navigationBar = self.navigationController?.navigationBar{
            navigationBar.topItem?.title = "Chats"
        }
        
        // Создание кнопки "Edit" в Navigation Bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        
        // Если пользователь не авторизован
        if FIRAuth.auth()?.currentUser?.uid == nil{
            //Включаем View Login/Register сразу же после его загрузки
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
    }
    
    //Функция перехода из View Chats в View Login/Register
    func handleLogout(){
        //Поиск ошибки
        do{
            try FIRAuth.auth()?.signOut()
        } catch let logoutError{
            print(logoutError)
        }
        //Выход
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}


