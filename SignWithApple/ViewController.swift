//
//  ViewController.swift
//  SignWithApple
//
//  Created by Ricky Erdiansyah on 25/11/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit
/// library untuk atuhentication apple
import AuthenticationServices

class ViewController: UIViewController {
    
    // MARK: - variable
    var password: String = "ricky123123"
    var user: User?

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var appleSignInButton: UIStackView!
    
    @IBAction func deleteee(_ sender: Any) {
        Keychain.deleteUserIdentifierFromKeychain()
    }
    
    @IBAction func DeleteBtn(_ sender: UIBarButtonItem) {
        Keychain.deleteUserIdentifierFromKeychain()
    }
    
    
    var text = ""
    @IBAction func myButton(_ sender: Any) {
        let alert = UIAlertController(title: "Test", message: "ISI", preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "isi text"
            
        }
        
        //self.text = textField.text!
        let ok = UIAlertAction(title: "OK", style: .default) { ACTION in
            let myTextField = alert.textFields![0] as UITextField
            self.text = myTextField.text!
            print("Your Text : ", self.text)
        }
        //print("aaa",self.text)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        print(Keychain.currentUserIdentifier)
        
    }
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        print(password)
        
        //setupView()
        setupProviderLoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = user?.email
        passwordTextField.text = user?.id
    }
    
    // MARK: Setup apple sign in button function
    /// cara 1 by code
    func setupView() {
        /// init apple sign in button
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        /// add target tap button
        appleButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([
            /// vertical Y dari view area
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            /// left dari view area
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            /// kanan dari view  area
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120)
        ])
        
    }
    
    /// cara 2 by adding  to stack view
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        self.appleSignInButton.addArrangedSubview(authorizationButton)
    }
    
    // MARK: - Tap Button Objc
    @objc func didTapSignInButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }
    
    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController, let user = sender as? User {
            mainVC.user = user
            mainVC.first = user.firstName
            mainVC.last = user.lastName
            mainVC.email = user.email
        }
    }
    
    @IBAction func unwindFromDetail(_ unwindSegue: UIStoryboardSegue) {
        guard let vc = unwindSegue.source as? MainViewController else { return }
        // Use data from the view controller which initiated the unwind segue
    }
    
}

// MARK: - EXTENSION
extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("Berhasil login")
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:

            let user = User(credentials: credentials)
            
            performSegue(withIdentifier: "toMain", sender: user)
            
            break
        default:
            break
        }
    }
    
    // MARK: - Did complete with error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Gagal Bos")
        print(error)
    }
    
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}
