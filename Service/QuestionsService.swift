//
//  QuestionsService.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation
import FirebaseFirestore

final class QuestionsService {
    
    static var shared = QuestionsService()
    private init() {}
    
    func getLevelsQuestions(userLevel: Int, completion: @escaping (Result<[Question], Error>)-> ()){
        
        var questions: [Question] = []
        
        Firestore.firestore().collection("Words").whereField("Level", isEqualTo: userLevel).getDocuments { query, error in
            let data = query?.documents
            data?.forEach({ document in
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
                option.correctAnswer = (data["correctAnswer"] as! String)
                question.options = option
                questions.append(question)
            })
            print(questions.count)
            completion(.success(questions))
        }
        
    }
}
