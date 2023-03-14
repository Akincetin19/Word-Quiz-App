//
//  CardView.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 11.03.2023.
//

import UIKit

class CardView: UIView {

    let optionA = CustomOptionButton(title: "A Şıkkı")
    let optionB = CustomOptionButton(title: "B Şıkkı")
    let optionC = CustomOptionButton(title: "C Şıkkı")
    let optionD = CustomOptionButton(title: "D Şıkkı")
    let gradientLayer = CAGradientLayer()
    let wordView = WordCardView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewDidLoad()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewDidLoad() {
        layer.cornerRadius = 32
        backgroundColor = UIColor(red: 147/255, green: 125/255, blue: 194/255, alpha: 1)
        
        isUserInteractionEnabled = false
        setupButtonsFrame()
        setupGradientLayer()
    }
    func setupGradientLayer() {
        
        let firstColor = CGColor.init(red: 255/255, green: 123/255, blue: 84/255, alpha: 1)
        let secondColor = CGColor.init(red: 147/255, green: 155/255, blue: 98/255, alpha: 1)
        
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 32
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setupCardViews(frame: CGRect, isUserInteractionEnable: Bool) {
        
        
        self.frame = frame
        isUserInteractionEnabled = isUserInteractionEnable
        alpha = alpha * 2
        layer.zPosition = layer.zPosition * 2
        gradientLayer.frame = self.bounds
     //   setupGradientLayer()
        setupButtonsFrame()
    }
    func configureViewWhenCreated(isUserInteractionEnable: Bool, alpha: CGFloat, zPosition: CGFloat) {
        self.alpha = alpha
        self.layer.zPosition = zPosition
        
    }
    func setupButtonsFrame() {
        addSubview(wordView)
        wordView.frame = CGRect(x: 32, y: 32, width: frame.width - 64, height: (frame.height / 2) - 16)
        addSubview(optionA)
        addSubview(optionB)
        addSubview(optionC)
        addSubview(optionD)
        optionA.frame = CGRect(x: 32, y: frame.height / 1.75, width: frame.width - 64, height: 50)
        optionB.frame = CGRect(x: 32, y: optionA.frame.maxY + 16, width: frame.width - 64, height: 50)
        optionC.frame = CGRect(x: 32, y: optionB.frame.maxY + 16, width: frame.width - 64, height: 50)
        optionD.frame = CGRect(x: 32, y: optionC.frame.maxY + 16, width: frame.width - 64, height: 50)
        
    }
    
}
