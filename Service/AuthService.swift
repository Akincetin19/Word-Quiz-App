//
//  AuthService.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation

import Firebase
import FirebaseFirestore

final class AuthService {
    
    static var shared = AuthService()
    private init() {}
    
    func signIn(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completion(.failure(error))
            }
            guard let result = result else {
                print("Hata Meydana Geldi")
                return
            }
            self.getUserInfo(uid: result.user.uid) { result in
                
                completion(result)
            }
        }
    }
    func getUserInfo(uid: String? = nil,completion: @escaping (Result<User,Error>) -> ()) {
        let uid = uid ?? Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("Users").document(uid).getDocument { query, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let query = query else {return}
            
            let data = query.data()
            guard let data = data else {return}
            var user = User()
            user.name = data["name"] as? String
            user.surname = data["surname"] as? String
            user.uid = data["uid"] as? String
            user.email = data["email"] as? String
            user.totalCorrectAnswer = data["totalCorrectAnswer"] as? Int
            user.totalWrongAnswer = data["totalWrongAnswer"] as? Int
            user.userLevel = data["userLevel"] as? Int
            
            completion(.success(user))
        }
    }
    
    func creaateUser(name: String, surname: String, email: String, password: String, completion: @escaping (Error) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(error)
            }
            guard let result = result else {return}
            var user = User()
            user.uid = result.user.uid
            user.name = name
            user.surname = surname
            user.email = email
            user.totalCorrectAnswer = 0
            user.totalWrongAnswer = 0
            user.userLevel = 1
            self.saveUserData(user: user) { error in
                completion(error)
            }
        }
    }
    func saveUserData(user: User , completion: @escaping (Error) -> ()) {
        
        Firestore.firestore().collection("Users").document(user.uid!).setData(
            ["name" : user.name!,
             "surname" : user.surname!,
             "email": user.email!,
             "uid": user.uid!,
             "userLevel": user.userLevel!,
             "totalWrongAnswer": user.totalWrongAnswer!,
             "totalCorrectAnswer": user.totalCorrectAnswer!]) { error in
                 
                 if let error = error {
                     completion(error)
                 }
             }
    }
    func handleMode(question: [Question], mode : Mode) {
        
        if mode == Mode.Test {
            setQuestionResult(questions: question, collection: "CorrectAnswers")
            removeQuestions(questions: question, collection: "WrongAnswers")
        }
        else if mode == Mode.Review {
            setQuestionResult(questions: question, collection: "WrongAnswers")
            removeQuestions(questions: question, collection: "CorrectAnswers")
        }
    }
    func addCorrectAnswers(questions: [Question]) {
        setQuestionResult(questions: questions, collection: "CorrectAnswers")
    }
    func addWrongAnswer(questions: [Question]) {
        setQuestionResult(questions: questions, collection: "WrongAnswers")
    }
    private func removeQuestions(questions: [Question], collection: String) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        questions.forEach { question in
            Firestore.firestore().collection("Users").document(uid).collection(collection).document(question.uid!).delete()
        }
    }
    private func setQuestionResult(questions: [Question], collection: String) {
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        questions.forEach { question in
            
            Firestore.firestore().collection("Users").document(uid).collection(collection).document(question.uid!).setData(["Level": question.level!,"Correctanswer": question.options!.correctAnswer!,"optionA": question.options!.optionA!,"optionB": question.options!.optionB!,"optionC": question.options!.optionC!,"optionD": question.options!.optionD!,"sampleSenctences1": question.sampleSenctences1!,"sampleSenctences2": question.sampleSenctences2!,"wordName": question.wordName!, "uid": question.uid!])
        }
    }
    func getQuestions( collection: String, completion: @escaping (Result<[Question], Error>)-> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        var questions: [Question] = []
        Firestore.firestore().collection("Users").document(uid).collection(collection).order(by: "Level").getDocuments { query, error in
            
            if let error = error {
                completion(.failure(error))
            }
            guard let query = query else {return}
            let data = query.documents
            data.forEach({ document in
                var question = Question()
                var option = Options()
                let data = document.data()
                question.sampleSenctences1 = (data["sampleSenctences1"] as! String)
                question.sampleSenctences2 = (data["sampleSenctences2"] as! String)
                question.uid = document.documentID
                question.level = (data["Level"] as! Int)
                question.wordName = (data["wordName"] as! String)
                option.optionA = (data["optionA"] as! String)
                option.optionB = (data["optionB"] as! String)
                option.optionC = (data["optionC"] as! String)
                option.optionD = (data["optionD"] as! String)
                option.correctAnswer = (data["Correctanswer"] as! String)
                question.options = option
                questions.append(question)
            })
            print(questions.count)
            completion(.success(questions))
        }
    }
}
