//
//  MainScrenCardView.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import UIKit

final class MainScrenCardView: UIView {

   
    var cardName: String
    var cardInfo: String
    
    lazy var cardNameLabel = UILabel(frame: .zero)
    lazy var cardInfoLabel = UILabel(frame: .zero)

    init(cardName: String, cardInfo: String) {
       
        self.cardName = cardName
        self.cardInfo = cardInfo
        super.init(frame: .zero)
        configureView()
    }
    fileprivate func configureView() {
        backgroundColor = UIColor(red: 225/255, green: 215/255, blue: 198/255, alpha: 1)
        layer.cornerRadius = 16
        configureCardNameLabel()
        configureCardInfoLabel()
    }
    
    private func configureCardNameLabel() {
        
        addSubview(cardNameLabel)
        cardNameLabel.text = cardName
        cardNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        cardNameLabel.textAlignment = .left
        cardNameLabel.frame = CGRect(x: 16, y: 16, width: 200, height: 40)
    }
    private func configureCardInfoLabel() {
        addSubview(cardInfoLabel)
        cardInfoLabel.text = cardInfo
        cardInfoLabel.font = UIFont.systemFont(ofSize: 16)
        cardInfoLabel.textAlignment = .left
        cardInfoLabel.frame = CGRect(x: 16, y: cardNameLabel.frame.minY + 36, width: 200, height: 40)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
