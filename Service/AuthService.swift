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
    func addCorrectAnswers(questions: [Question]) {
        
        setQuestionResult(questions: questions, collection: "CorrectAnswers")
    }
    func addWrongAnswer(questions: [Question]) {
        setQuestionResult(questions: questions, collection: "WrongAnswers")
    }
    private func setQuestionResult(questions: [Question], collection: String) {
        
        questions.forEach { question in
            let uid = Auth.auth().currentUser?.uid ?? ""
            Firestore.firestore().collection("Users").document(uid).collection(collection).document(question.uid!).setData(["Level": question.level!,"Correctanswer": question.options!.correctAnswer!,"optionA": question.options!.optionA!,"optionB": question.options!.optionB!,"optionC": question.options!.optionC!,"optionD": question.options!.optionD!,"sampleSenctences1": question.sampleSenctences1!,"sampleSenctences2": question.sampleSenctences2!,"wordName": question.wordName!, "uid": question.uid!])
        }
    }
}
