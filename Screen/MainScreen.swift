//
//  MainScreen.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import UIKit
import Lottie
protocol MainScreenProtocol: AnyObject {
    
    func configureView()
    func configureCards(user: User)
    func makeAlert(error: Error)
}

final class MainScreen: UIViewController {

    let gradientLayer = CAGradientLayer()
    private let learnCardView = MainScrenCardView(cardName: "Test Et", cardInfo: "")
    private let testCardView = MainScrenCardView(cardName: "Tekrar Et", cardInfo: "")
    private let reviewCardView = MainScrenCardView(cardName: "Gözden Geçir", cardInfo: "")
    var learnCardAnimation = LottieAnimationView(name: "lookOver")
    var testCardAnimation = LottieAnimationView(name: "Test Et")
    var reviewCardAnimation = LottieAnimationView(name: "Gözden Geçir")
    private var viewModel : MainScreenViewModelProtocol?
    private var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenViewModel()
        viewModel?.view = self
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewDidLoad()
        addCardAnimations()
        
    }
    deinit {
        print("Main Screen Deinit")
    }
    @objc func goToTestPage() {

        navigationController?.pushViewController(ViewController(user: user ?? User()), animated: true)
    }
    fileprivate func addCardAnimations() {
        
        createLottieAnimation(cardView: learnCardView, animation: learnCardAnimation)
        createLottieAnimation(cardView: reviewCardView, animation: reviewCardAnimation)
        createLottieAnimation(cardView: testCardView, animation: testCardAnimation)
        
    }
    fileprivate func createLottieAnimation(cardView: MainScrenCardView, animation: LottieAnimationView) {
        
        animation.frame = cardView.animationView.frame
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        cardView.addSubview(animation)
        
        animation.play()
        
        
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

extension MainScreen: MainScreenProtocol {
    func makeAlert(error: Error) {
        self.makeAlert(view: self, error: error)
    }
    
    func configureView() {
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
    func configureCards(user: User) {
        
        learnCardView.cardInfoLabel.text = "\(user.userLevel!)"
        testCardView.cardInfoLabel.text = "\(user.totalWrongAnswer!) Yanlış Cevap Verdiniz"
        reviewCardView.cardInfoLabel.text = "\(user.totalCorrectAnswer!) Doğru Cevap Verdiniz"
        self.user = user
    }
}
