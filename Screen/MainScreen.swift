//
//  MainScreen.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import UIKit

class MainScreen: UIViewController {

    let gradientLayer = CAGradientLayer()
    private let learnCardView = MainScrenCardView(cardName: "Test Et", cardInfo: "%1 Tamamlandı")
    private let testCardView = MainScrenCardView(cardName: "Gözden Geçir", cardInfo: "10 Yanlış yaptın")
    private let reviewCardView = MainScrenCardView(cardName: "Tekrar Et", cardInfo: "38 Soruyu doğru yanıtladın")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    @objc func goToTestPage() {
        let vc = ViewController()
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    fileprivate func configureView() {
        view.backgroundColor = UIColor.init(red: 210/255, green: 123/255, blue: 84/255, alpha: 1)
        view.addSubview(learnCardView)
        view.addSubview(testCardView)
        view.addSubview(reviewCardView)
        let width: CGFloat = view.frame.width - 32
        let height: CGFloat = 100
        let frame = CGRect(x: (view.frame.width - width) / 2, y: (view.frame.height - height) / 6, width: width, height: height)
        learnCardView.frame = frame
        testCardView.frame = CGRect(x: 16, y: learnCardView.frame.maxY + 16, width: width, height: height)
        reviewCardView.frame = CGRect(x: 16, y: testCardView.frame.maxY + 16, width: width, height: height)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToTestPage))
        learnCardView.addGestureRecognizer(gesture)
        addGradientLayer()
    }
    fileprivate func addGradientLayer() {
        let firstColor = CGColor.init(red: 255/255, green: 123/255, blue: 84/255, alpha: 1)
        let secondColor = CGColor.init(red: 147/255, green: 155/255, blue: 98/255, alpha: 1)
        
        gradientLayer.colors = [firstColor, secondColor]
        
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 32
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.locations = [0.0, 0.75, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
}
