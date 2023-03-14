//
//  AddDataViewController.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import UIKit
import FirebaseFirestore
import Firebase

class AddDataViewController: UIViewController {

    
    lazy var wordName = CustomTextField(placeholderText: "word Name")
    lazy var sampleSenctences1 = CustomTextField(placeholderText: "örnek cümle 1")
    lazy var sampleSenctences2 = CustomTextField(placeholderText: "örnek cümle 2")
    lazy var optionA = CustomTextField(placeholderText: "a şıkkı")
    lazy var optionB = CustomTextField(placeholderText: "b şıkkı")
    lazy var optionC = CustomTextField(placeholderText: "c şıkkı")
    lazy var optionD = CustomTextField(placeholderText: "d şıkkı")
    lazy var coorectAnswer = CustomTextField(placeholderText: "Doğru Cevap")
    
    let id = UUID().uuidString
    
    lazy var button = CustomLoginButton(title: "Gönder", color: .blue)
    lazy var stackView = UIStackView(arrangedSubviews: [wordName, sampleSenctences1, sampleSenctences2, optionA, optionB, optionC, optionD, coorectAnswer, button])
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16))
        
        button.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
        
    }
    
    @objc func uploadData() {

        Firestore.firestore().collection("Words").document("nXlYcGAy9H5ATEeLbzz0").collection("5").addDocument(data: ["wordName": wordName.text ?? "",
                                                                                               "sampleSenctences1": sampleSenctences1.text ?? "",
                                                                                               "sampleSenctences2": sampleSenctences2.text ?? "",
                                                                                               "optionA" : optionA.text ?? "",
                                                                                               "optionB" : optionB.text ?? "",
                                                                                               "optionC" : optionC.text ?? "",
                                                                                               "optionD" : optionD.text ?? "",
                                                                                               "correctAnswer" : coorectAnswer.text ?? ""])
        
        wordName.text = ""
        sampleSenctences2.text = ""
        sampleSenctences1.text = ""
        optionA.text = ""
        optionB.text = ""
        optionC.text = ""
        optionD.text = ""
        coorectAnswer.text = ""
    }
}
