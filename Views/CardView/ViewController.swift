//
//  ViewController.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit
import Lottie

protocol TestScreenProtocol: AnyObject {
    func configureView()
    var isAnswerQuestion: Bindable<String> {get set}
    func startAnimations()
    func configureFirstCard()
    func handleFirstCardFrame()
    func handleSecondCardFrame()
    func createNewView()
    func handleSecondCardaAlpha()
    func handleFinishAnimation()
}

final class ViewController: UIViewController {

    private let width: CGFloat = 350
    private let height: CGFloat = 650
    private var initialCardFrame: CGRect!
    private var intermediateCardFrame: CGRect!
    private var finalCardFrame: CGRect!
    private var alpha: CGFloat = 1
    private var views: [CardView] = []
    private var panGesture: UITapGestureRecognizer!
    
    private var viewModel = QuestionViewModel()
    var isAnswerQuestion: Bindable<String> = Bindable<String>()
    private var backButtonImage: UIImageView = {
       
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(systemName: "chevron.left.circle.fill")?.withTintColor(UIColor.init(red: 255/255, green: 123/255, blue: 84/255, alpha: 1), renderingMode: .alwaysOriginal)
        return imgView
    }()
    init(user: User, mode: Mode) {
        viewModel.user = user
        viewModel.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    deinit {
        print("gitti")
    }
    
    fileprivate func configureCardFrame() {
        initialCardFrame = CGRect(x: (view.frame.width - width) / 2, y: (view.frame.height - height) / 2 + 24, width: width, height: height)
        intermediateCardFrame = CGRect(x: (view.frame.width - width *  0.9) / 2, y: (view.frame.height - height + 30) / 2 + 24, width: width * 0.9, height: height)
        finalCardFrame = CGRect(x: (view.frame.width - width *  0.8) / 2, y: (view.frame.height - height + 60) / 2 + 24, width: width * 0.8, height: height)
        [initialCardFrame, intermediateCardFrame, finalCardFrame].forEach { frame in
            
            let view = CardView(frame: frame!)
            view.alpha = alpha
            view.layer.zPosition = alpha
            alpha = alpha / 2
            self.views.append(view)
            self.view.addSubview(view)
            addTargetAllButtons(view: view)
        }
    }
    
    fileprivate func configureBackButtonImage() {
        view.addSubview(backButtonImage)
        backButtonImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 64, height: 64))
        let backButtonClickedGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackButtonClicked))
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(backButtonClickedGesture)
    }
    fileprivate func addTargetAllButtons(view : CardView) {
        view.optionA.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionB.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionC.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionD.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    //MARK: -> Buttons Targets
    @objc func handleBackButtonClicked() {
        self.handleBackAlert()
    }
    fileprivate func goToMainPage() {
        navigationController?.popViewController(animated: true)
    }
    @objc func buttonTapped(sender: UIButton) {
  
        let result = viewModel.checkAnswer(answer: sender.titleLabel?.text ?? "")
        switch result {
        case true:
            sender.backgroundColor = .green
        case false:
            sender.backgroundColor = .red
        }
        isAnswerQuestion.value = sender.titleLabel?.text
    }
    //MARK: -> Animations
   
    
    fileprivate func removeCard(view: UIView) {
        
        view.alpha = 0
        view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -4)
        view.frame = CGRect(x: view.frame.minX * 5, y: view.frame.minY, width: self.width, height: self.height)
        self.views.removeFirst()
        self.view.willRemoveSubview(view)
    }
    func handleFinishAlert() {
        let dialogMessage = UIAlertController(title: "Tebrikler Level Atladınız", message: "Yeni Soruları Görmek İstiyor Musunuz", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Evet", style: .default) { [weak self] (_) in
            guard let self = self else {return}
            self.viewModel.viewDidLoad()
        }
        let no = UIAlertAction(title: "Hayır", style: .default) { [weak self] (_) in
            guard let self = self else {return}
            self.goToMainPage()
        }
        dialogMessage.addAction(yes)
        dialogMessage.addAction(no)
        present(dialogMessage, animated: true, completion: nil)
    }
    func handleBackAlert() {
        let dialogMessage = UIAlertController(title: "Ops", message: "Sadece \(self.viewModel.questions.count) kelime kaldı", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Öğenmeye Devam", style: .default)
        let no = UIAlertAction(title: "Yine De Çık", style: .default) { [weak self] (_) in
            guard let self = self else {return}
            self.goToMainPage()
        }
        dialogMessage.addAction(yes)
        dialogMessage.addAction(no)
        present(dialogMessage, animated: true, completion: nil)
    }
}

extension ViewController: TestScreenProtocol {
    
    func configureView() {
        alpha = 1
        view.backgroundColor = UIColor(red: 225/255, green: 215/255, blue: 198/255, alpha: 1)
        view.backgroundColor = .white
        configureCardFrame()
        configureBackButtonImage()
        view.bringSubviewToFront(views[0])
    }
    func startAnimations() {
        let initialView = self.views[0]
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            if self.viewModel.questions.count != 1 {
                self.views[1].setCards(question: self.viewModel.questions[1])
                self.views[1].alpha = 1
            }
            
            self.removeCard(view: initialView)
        }) { (_) in
            initialView.removeFromSuperview()
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 1) {
                self.viewModel.handleAnimations()
            }
        }
        viewModel.questions.removeFirst()
    }
    func configureFirstCard() {
        views[0].isUserInteractionEnabled = true
        //    views[0].setupGradientLayer()
        views[0].setupButtonsFrame()
        views[0].setCards(question: viewModel.questions.first!)
    }
    func handleFirstCardFrame() {
        
        let firstView = self.views[0]
        firstView.setupCardViews(frame: self.initialCardFrame, isUserInteractionEnable: true)
    }
    func handleSecondCardFrame() {
        let secondView = self.views[1]
        secondView.setupCardViews(frame: self.intermediateCardFrame, isUserInteractionEnable: false)
    }
    func createNewView() {
        let newView = CardView(frame: self.finalCardFrame)
        newView.alpha = 0
        newView.configureViewWhenCreated(isUserInteractionEnable: false, alpha: 0.25, zPosition: 0.25)
        self.view.addSubview(newView)
        self.views.append(newView)
        addTargetAllButtons(view: newView)
    }
    func handleSecondCardaAlpha() {
        views[1].setCards(question: viewModel.questions[1])
        views[1].alpha = 1
    }
    func handleFinishAnimation() {
        var lootieAnimation = LottieAnimationView()
        
        lootieAnimation = .init(name: "celebration")
        lootieAnimation.frame = view.bounds
        lootieAnimation.contentMode = .scaleAspectFit
        lootieAnimation.loopMode = .playOnce
        lootieAnimation.animationSpeed = 1
        view.addSubview(lootieAnimation)
        lootieAnimation.play()
        
        lootieAnimation.play {[weak self] flag in
            
            guard let self = self else {return}
            self.view.willRemoveSubview(lootieAnimation)
            lootieAnimation.removeFromSuperview()
            
            if self.viewModel.mode == .Learn {
                self.handleFinishAlert()
            }
            
        }
    }
    
}
