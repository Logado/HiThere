//
//  LoginController.swift
//  HiThere
//
//  Created by Александр Кириченко on 18.03.17.
//  Copyright © 2017 Александр Кириченко. All rights reserved.
//

import UIKit
import Firebase

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
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    //Создание переключателя
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.backgroundColor = UIColor(colorLiteralRed: 52/255, green: 171/255, blue: 224/255, alpha: 1)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Задний фон View
        view.backgroundColor = UIColor(colorLiteralRed: 52/255, green: 171/255, blue: 224/255, alpha: 1)
        
        //Отображение объектов на View
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        setupLoginRegisterSegmentedControl()
        setupInputsContainerView()
        setupLoginRegisterButton()
    }
    
    //Работаем с переключением с Register на Login
    func handleLoginRegisterChange(){
        
        //Сохраняем Title по индексу
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        
        //Присваиваем Title кнопке снизу
        loginRegisterButton.setTitle(title, for: .normal)
        
        //Меняем высоту контейнера в зависимости от индекса переключателя
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        // Убираем окно для ввода Name при Login и возвращам при регистрации
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        nameTextFieldHeightAnchor?.isActive = true
        
        //Увелчиваем окна для ввода Email и Password и возвращаем при регистрации
        emailTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        passwordTextFieldHeightAnchor?.isActive = true
        
    }

    
    // Функция Регистрации при нажатии кнопки регистрации
    func handleRegister(){
        //Проверка заполненности окон email и password
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not Valid")
            return
        }
        // Аутентификация пользователя
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            //Выводим ошибку
            if error != nil{
                print(error!)
                return
            }
            //Проверка уникального ключа пользователя UID
            guard (user?.uid) != nil else{
                print("UID is not correct")
                return
            }
            
            //При успешной аутентификации добавляем Name и Email в БД
            let values = ["name": name, "email": email]
            let ref = FIRDatabase.database().reference(fromURL: "https://hi-there-a3dd4.firebaseio.com/")
            let usersRef = ref.child("users").child((user?.uid)!)
            usersRef.updateChildValues(values, withCompletionBlock: { (errorRef, ref) in
                //Выводим ошибку
                if errorRef != nil{
                    print(errorRef!)
                    return
                }
                print("Saved user successfully into db")
                //Закрываем View Login/Register при успешной регистрации
                self.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    //Настройка переключателя Login/Register
    func setupLoginRegisterSegmentedControl(){
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    //Настройка контейнера под окна для ввода
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    func setupInputsContainerView(){
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: 12).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
         inputsContainerViewHeightAnchor?.isActive = true
        
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
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    //Настройка окна ввода Name
    func setupNameTextField(){
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
    }
    
    //Настройка разделителя внизу окна Name
    func setupNameSeparatorView(){
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    //Настройка окна ввода Email
    func setupEmailTextField(){
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
    }
    
    //Настройка разделителя внизу окна Email
    func setupEmailSeparatorView(){
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
         emailSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    //Настройка окна ввода Password
    func setupPasswordTextField(){
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }

    
    // Изменение цвета контента Status Bar(оператор, часы, батарея)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
}

