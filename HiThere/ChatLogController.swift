//
//  ChatLogController.swift
//  HiThere
//
//  Created by Александр Кириченко on 21.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController{
    
    var user: User?{
        //В отдельном чате устанавливаем в title имя пользователя, с которым общаемся
        didSet{
            navigationItem.title = user?.name
        }
    }
    //Создание окна для набора сообщения в чате
    let inputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        setupInputsComponent()
    }
    //Добавление элементов на View ChatLogController
    func setupInputsComponent(){
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
       
        // Размеры и положение containerView
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Cоздание кнопки Send
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
    
        // Размеры и положение кнопки Send
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //Добавление окна ввода для сообщения inputTextField
        view.addSubview(inputTextField)
        
        // Размеры и положение inputTextField
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //Создание разделителя
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(colorLiteralRed: 220/255, green: 220/255, blue: 220/255, alpha: 220/255)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView)
        
        // Размеры и положение inputTextField разделителя
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }
    //Отправка сообщения + его сохранение в БД с параметрами: text - текст, toId - кому, fromId - от кого, timestamp - время
    func handleSend(){
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let ref = FIRDatabase.database().reference().child("messages")
        //Автогенерация ID
        let childRef = ref.childByAutoId()
        let toId = user?.id
        let fromId = FIRAuth.auth()?.currentUser?.uid
        //Формирование данных для БД
        let values =  ["text": inputTextField.text!, "toId": toId!, "fromId": fromId!, "timestamp": timestamp] as [String : Any]
        //Загрузка в БД
        childRef.updateChildValues(values)
        
    }
}
