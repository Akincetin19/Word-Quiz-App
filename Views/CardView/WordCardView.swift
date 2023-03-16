//
//  WordCardView.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 11.03.2023.
//

import UIKit

final class WordCardView: UIView {

    
    var wordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    var sampleSenctencesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(wordLabel)
        wordLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        addSubview(sampleSenctencesLabel)
        sampleSenctencesLabel.anchor(top: wordLabel.bottomAnchor, leading: wordLabel.leadingAnchor, bottom: nil, trailing: wordLabel.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        backgroundColor = .white
        layer.cornerRadius = 32
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureWordcardView(question : Question) {
        
        wordLabel.text = question.wordName
        sampleSenctencesLabel.text = "\(question.sampleSenctences1!) \n \n \(question.sampleSenctences2!)"
    }
    
}
