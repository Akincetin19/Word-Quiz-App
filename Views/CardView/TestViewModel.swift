//
//  TestViewModel.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation


protocol TestScreenViewModelProtocol {
    var view: TestScreenProtocol? { get set }
    func viewDidLoad()
    func checkAnswer(answer: String) -> Bool
}

final class TestViewModel {
    
    weak var view: TestScreenProtocol?
   
    var questions: [Question] = []
    private var correctAnswers: [Question] = []
    private var wrongAnswers: [Question] = []
    var user: User?
    
    func answeredQuestion() {
        view?.isAnswerQuestion.bind(observer: { option in
            self.view?.startAnimations()
            
        })
    }
    func handleAnimations() {
        switch self.questions.count {
        case 0:
            self.view?.handleFinishAnimation()
            saveUserInfo()
        case 1:
            self.view?.handleFirstCardFrame()
        case 2:
            self.view?.handleFirstCardFrame()
            self.view?.handleSecondCardFrame()
        default:
            self.view?.handleFirstCardFrame()
            self.view?.handleSecondCardFrame()
            self.view?.createNewView()
        }
    }
    private func saveUserInfo() {
        self.user?.userLevel! += 1
        self.user?.totalWrongAnswer! += self.wrongAnswers.count
        self.user?.totalCorrectAnswer! += self.correctAnswers.count
        AuthService.shared.saveUserData(user: user ?? User()) { (_) in}
        AuthService.shared.addCorrectAnswers(questions: correctAnswers)
        AuthService.shared.addWrongAnswer(questions: wrongAnswers)
    }
    func x() {
        
    }
    
    private func getQuestions(user : User) {
        guard let level = user.userLevel else {return}
        QuestionsService.shared.getLevelsQuestions(userLevel: level) { result in
            
            switch result {
            case.success(let data):
                self.questions.append(contentsOf: data)
                self.view?.configureFirstCard()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TestViewModel: TestScreenViewModelProtocol {
    
    func checkAnswer(answer: String) -> Bool {
        
        let result = answer == questions.first?.options?.correctAnswer!
        
        switch result {
        case true:
            self.correctAnswers.append(self.questions.first!)
          //  AuthService.shared.addCorrectAnswer(question: self.questions.first!)
        case false:
            self.wrongAnswers.append(self.questions.first!)
          //  AuthService.shared.addWrongAnswer(question: self.questions.first!)
        }
    //    updateUserInfo()
        return result
    }
    
    func viewDidLoad() {
        guard let user = user else {return}
        getQuestions(user: user)
        self.view?.configureView()
        self.answeredQuestion()
    }
}
