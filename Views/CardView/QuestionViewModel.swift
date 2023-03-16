//
//  TestViewModel.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation


protocol QuestionScreenViewModelProtocol {
    var view: TestScreenProtocol? { get set }
    func viewDidLoad()
    func checkAnswer(answer: String) -> Bool
}

final class QuestionViewModel {
    
    weak var view: TestScreenProtocol?
    var questions: [Question] = []
    private var correctAnswers: [Question] = []
    private var wrongAnswers: [Question] = []
    var user: User?
    var mode: Mode?
    
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
        
        switch mode {
        case.Learn:
            self.user?.userLevel! += 1
            self.user?.totalWrongAnswer! += self.wrongAnswers.count
            self.user?.totalCorrectAnswer! += self.correctAnswers.count
            AuthService.shared.saveUserData(user: user ?? User()) { (_) in}
            AuthService.shared.addCorrectAnswers(questions: correctAnswers)
            AuthService.shared.addWrongAnswer(questions: wrongAnswers)
        case .Test:
            self.user?.totalWrongAnswer! -= self.correctAnswers.count
            self.user?.totalCorrectAnswer! += self.correctAnswers.count
            AuthService.shared.handleMode(question: correctAnswers, mode: .Test)
            AuthService.shared.saveUserData(user: user ?? User()) { (_) in}
        case.Review:
            print("")
            self.user?.totalCorrectAnswer! -= self.wrongAnswers.count
            self.user?.totalWrongAnswer! +=  self.wrongAnswers.count
            AuthService.shared.handleMode(question: wrongAnswers, mode: .Review)
            AuthService.shared.saveUserData(user: user ?? User()) { (_) in}
        default:
            print()
        }
    }
    private func getQuestions(user : User) {
        
        switch mode {
        case.Learn:
            guard let level = user.userLevel else {return}
            QuestionsService.shared.getLevelsQuestions(userLevel: level) { result in
                self.handleWithResult(result)
            }
        case .Test:
            AuthService.shared.getQuestions(collection: "WrongAnswers") { result in
                self.handleWithResult(result)
            }
        case.Review:
            AuthService.shared.getQuestions(collection: "CorrectAnswers") { result in
                self.handleWithResult(result)
            }
        default:
            print()
        }
    }
    fileprivate func handleWithResult(_ result: Result<[Question], Error>) {
        switch result {
        case.success(let data):
            self.questions.append(contentsOf: data)
            self.view?.configureFirstCard()
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}
extension QuestionViewModel: QuestionScreenViewModelProtocol {
    func checkAnswer(answer: String) -> Bool {
        
        let result = answer == questions.first?.options?.correctAnswer!
        
        switch result {
        case true:
            self.correctAnswers.append(self.questions.first!)
        case false:
            self.wrongAnswers.append(self.questions.first!)
        }
        return result
    }
    
    func viewDidLoad() {
        guard let user = user else {return}
        getQuestions(user: user)
        self.view?.configureView()
        self.answeredQuestion()
    }
}
