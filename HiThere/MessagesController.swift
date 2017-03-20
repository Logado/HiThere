//
//  ViewController.swift
//  HiThere
//
//  Created by Александр Кириченко on 09.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание Navigation Bar и создание Title "Chats"
        if let navigationBar = self.navigationController?.navigationBar{
            navigationBar.topItem?.title = "Chats"
        }
        
        // Создание кнопки "Edit" в Navigation Bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        
        //Создание иконки New Message и переход в NewMessageView
        let imageNewMessage = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageNewMessage, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    //
    func handleNewMessage(){
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    //Функция проверки авторизованного пользователя
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil{
            //Включаем View Login/Register сразу же после его загрузки
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else{
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                print(snapshot)
                
            }, withCancel: nil)
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


