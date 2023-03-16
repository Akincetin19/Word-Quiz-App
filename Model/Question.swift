//
//  Question.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation

struct Question {
    
    var uid: String?
    var wordName: String?
    var sampleSenctences1: String?
    var sampleSenctences2: String?
    var options: Options?
    var level: Int?
}
struct Options {
    
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var correctAnswer: String?
}
