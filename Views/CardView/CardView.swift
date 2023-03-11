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
    }
    func setupCardViews(frame: CGRect, isUserInteractionEnable: Bool) {
        self.frame = frame
        isUserInteractionEnabled = isUserInteractionEnable
        alpha = alpha * 2
        layer.zPosition = layer.zPosition * 2
        setupButtonsFrame()
    }
    func configureViewWhenCreated(isUserInteractionEnable: Bool, alpha: CGFloat, zPosition: CGFloat) {
        self.alpha = alpha
        self.layer.zPosition = zPosition
    }
    func setupButtonsFrame() {
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
