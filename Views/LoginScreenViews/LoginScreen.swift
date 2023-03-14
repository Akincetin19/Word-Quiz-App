//
//  LoginScreen.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

class LoginScreen: UIViewController {

    //MARK: -> Views
    let loginView = LoginView(frame: .zero)
    let signUpView = SignUpView(frame: .zero)
    let padding : CGFloat = 35
    
    var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView() 
        configureView()
    }
    //MARK: -> ConfigureView
    fileprivate func configureView() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        
        loginView.centerInSuperview(size: .init(width: view.frame.width - 50, height: view.frame.height - 150))
        loginView.signUpButton.addTarget(self, action: #selector(self.makeAnimation(sender:)), for: .touchUpInside)
        loginView.configureStackView()
        loginView.loginButton.addTarget(self, action: #selector(goToMainPage), for: .touchUpInside)
        
    }
    fileprivate func configureSignUpView() {
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
        signUpView.loginButton.addTarget(self, action: #selector(self.makeAnimation(sender:)), for: .touchUpInside)
        
        /*
        signUpView.removeConstraints(signUpView.constraints)
        
        
        NSLayoutConstraint.activate([
            signUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding),
            signUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            signUpView.widthAnchor.constraint(equalToConstant: 323)
        ])
      */
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    @objc func goToMainPage() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
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
}
