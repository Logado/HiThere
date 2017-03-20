//
//  NewMessageController.swift
//  HiThere
//
//  Created by Александр Кириченко on 20.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit
import  Firebase

class NewMessageController: UITableViewController {

    let cellId = "DefaultCell"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Создание кнопки назад
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBack))
        
        //Создание Title для Navigation Bar
        navigationItem.title = "New Message"
        
        //Регистрируем класс для создания новых ячеек
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        //Выгружаем пользователей в таблицу
        fetchUser()
    }
    
    //Функция добавления пользователей в таблицу
    func fetchUser(){
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            //Создаем словарь с типом данных [String: AnyObject] ???
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.setValuesForKeys(dictionary)
                
                //Добавляем User в массив
                self.users.append(user)
               
                //Обновляем таблицу
                self.tableView.reloadData()
            }
        }, withCancel: nil)
    }
    
    //Функция обработки кнопки "Отмена", закрываем NewMessage View
    func handleBack(){
        dismiss(animated: true, completion: nil)
    }
    
    //Количество строк для вывода
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //Выводим пользователей в таблицу
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
}

//Создаем класс для настройки ячеек
class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
