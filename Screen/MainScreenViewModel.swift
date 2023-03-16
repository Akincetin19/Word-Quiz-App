//
//  MainScreenViewModel.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 15.03.2023.
//

import Foundation


protocol MainScreenViewModelProtocol {
    
    var view: MainScreenProtocol? {get set}
    func viewDidLoad()
}

final class MainScreenViewModel {
    
    weak var view: MainScreenProtocol?
    
    private func getUserInfo() {
        AuthService.shared.getUserInfo() {[weak self] result in
            guard let self = self else {return}
            
            switch result{
            case.failure(let error):
                self.view?.makeAlert(error: error)
            case.success(let user):
                self.view?.configureCards(user: user)
            }
        }
    }
    func x() {
        print("xxx")
    }
}
extension MainScreenViewModel: MainScreenViewModelProtocol {
    func viewDidLoad() {
        view?.configureView()
        self.getUserInfo()
    }
    
    
}
