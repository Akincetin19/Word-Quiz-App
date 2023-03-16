//
//  LoginScreen.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    
    func configureView()
    func makeAlert(error: Error)
    func goToMainPage()
}

final class LoginScreen: UIViewController {

    //MARK: -> Views
    let loginView = LoginView(frame: .zero)
    let signUpView = SignUpView(frame: .zero)
    let padding : CGFloat = 35
    
    var widthConstraint: NSLayoutConstraint!
    private var viewModel = LoginScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }

    //MARK: -> ANIMATIONS
    @objc fileprivate func makeAnimation(sender: UIButton) {
        
        let loginViewY = loginView.frame.midY
        let singUpViewY = signUpView.frame.midY
        let scale = 180 * (singUpViewY - loginViewY) / padding
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            self.makeAnimationLeftRight(scale1: -scale)
        }) { (_) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                self.makeAnimationUpDown(signUpViewY: singUpViewY, loginViewY: loginViewY, scale1: scale)
            }) { (_) in
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                    self.makeAnimationLeftRight(scale1: scale)
                })
            }
        }
    }
    deinit {
        print("")
    }
    fileprivate func makeAnimationLeftRight(scale1: CGFloat) {
        
        self.loginView.transform = self.loginView.transform.translatedBy(x: scale1, y: 0)
        self.signUpView.transform = self.signUpView.transform.translatedBy(x: -scale1, y: 0)
    }
    fileprivate func makeAnimationUpDown(signUpViewY: CGFloat, loginViewY: CGFloat, scale1: CGFloat) {
        self.loginView.transform = self.loginView.transform.translatedBy(x: 0, y: signUpViewY - loginViewY)
        self.signUpView.transform = self.signUpView.transform.translatedBy(x: 0, y: loginViewY - signUpViewY)
        self.signUpView.layer.zPosition = scale1 / 180
        self.loginView.layer.zPosition = -scale1 / 180
        self.signUpView.alpha = CGFloat(scale1 > 0 ? 1 : 0.35)
        self.loginView.alpha = CGFloat(scale1 > 0 ? 0.35 : 1)
        self.loginView.isUserInteractionEnabled = scale1 <= 0
        self.signUpView.isUserInteractionEnabled = scale1 > 0
    }
    func addTarget() {
        loginView.loginButton.addTarget(self, action: #selector(logIn(sender:)), for: .touchUpInside)
        signUpView.loginButton.addTarget(self, action: #selector(self.makeAnimation(sender:)), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(self.makeAnimation(sender:)), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(createUser(sender:)), for: .touchUpInside)
    }
    @objc func createUser(sender: UIButton) {
        
        viewModel.createUSer(email: signUpView.emailTextField.text!, name: signUpView.nameTextField.text!, surname: signUpView.surnameTextField.text!, password: signUpView.passwordTextField.text!)
    }
    @objc func logIn(sender: UIButton) {
        
        viewModel.logIn(email: loginView.emailTextField.text!, password: loginView.passwordTextField.text!)
    }
    func configureSignUpView() {
        view.addSubview(signUpView)
        NSLayoutConstraint.activate([
            signUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding),
            signUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            signUpView.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        view.layoutIfNeeded()
        signUpView.configureStackView()
        //    signUpView.updateConstraints()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func configureLoginView() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        loginView.centerInSuperview(size: .init(width: view.frame.width - 50, height: view.frame.height - 150))
        loginView.configureStackView()
        loginView.isUserInteractionEnabled = true
        loginView.stackView.isUserInteractionEnabled = true
        addTarget()
    }
}
extension LoginScreen: LoginScreenProtocol {
    func makeAlert(error: Error) {
        self.makeAlert(view: self, error: error)
    }
    func configureView() {
        configureSignUpView()
        configureLoginView()
    }
    func goToMainPage() {
        
        let vc = MainScreen()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
