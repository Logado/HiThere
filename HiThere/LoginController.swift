//
//  LoginController.swift
//  HiThere
//
//  Created by Александр Кириченко on 18.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // Создание контейнера под окна для ввода
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Создание окна для ввода Name
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //Создание разделителя после Name
    let nameSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(colorLiteralRed: 220/255, green: 220/255, blue: 220/255, alpha: 220/255)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    //Создание окна для ввода Email
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //Создание разделителя после Email
    let emailSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(colorLiteralRed: 220/255, green: 220/255, blue: 220/255, alpha: 220/255)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    //Создание окна для ввода Password
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    
    //Создание кнопки регистрации
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Задний фон View
        view.backgroundColor = UIColor(colorLiteralRed: 52/255, green: 171/255, blue: 224/255, alpha: 1)
        
        //Отображение элементов на View
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        setupInputsContainerView()
        setuploginRegisterButton()
    }
    

    //Настройка контейнера под окна для ввода
    func setupInputsContainerView(){
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Отображение окна для ввода Name
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        setupNameTextField()
        setupNameSeparatorView()
        setupEmailTextField()
        setupEmailSeparatorView()
        setupPasswordTextField()
    }
    
    //Настройка кнопки регистрации
    func setuploginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //Настройка окна ввода Name
    func setupNameTextField(){
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    //Настройка разделителя внизу окна Name
    func setupNameSeparatorView(){
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    //Настройка окна ввода Email
    func setupEmailTextField(){
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    //Настройка разделителя внизу окна Email
    func setupEmailSeparatorView(){
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
         emailSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    //Настройка окна ввода Password
    func setupPasswordTextField(){
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }

    
    // Изменение цвета контента Status Bar(оператор, часы, батарея)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
}

