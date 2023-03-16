//
//  LoginScreenViewModel.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 15.03.2023.
//

import Foundation


protocol LoginScrenViewModelProtocol {
    
    var view: LoginScreenProtocol? {get set}
    func viewDidLoad()
    func createUSer(email: String, name: String, surname: String, password: String)
    func logIn(email: String, password: String)
}


final class LoginScreenViewModel {
    
    weak var view: LoginScreenProtocol?
   
}
extension LoginScreenViewModel: LoginScrenViewModelProtocol {
    func logIn(email: String, password: String) {
        
        AuthService.shared.signIn(email: email, password: password) { result in
            
            switch result {
            case.success(_):
                self.view?.goToMainPage()
            case .failure(let error):
                self.view?.makeAlert(error: error)
            }
        }
    }
    func createUSer(email: String, name: String, surname: String, password: String) {
        AuthService.shared.creaateUser(name: name, surname: surname, email: email, password: password) { error in
            
            self.view?.makeAlert(error: error)
        }
    }
    func viewDidLoad() {
        view?.configureView()
    }
}
