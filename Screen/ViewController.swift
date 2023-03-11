//
//  ViewController.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    private var questionCount = 10
    private let width: CGFloat = 350
    private let height: CGFloat = 650
    private var initialCardFrame: CGRect!
    private var intermediateCardFrame: CGRect!
    private var finalCardFrame: CGRect!
    private var alpha: CGFloat = 1
    private var views: [CardView] = []
    private var panGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            configureView()
        view.backgroundColor = UIColor(red: 225/255, green: 215/255, blue: 198/255, alpha: 1)
    }
    fileprivate func configureView() {
        view.backgroundColor = .white
        
        initialCardFrame = CGRect(x: (view.frame.width - width) / 2, y: (view.frame.height - height) / 2, width: width, height: height)
        intermediateCardFrame = CGRect(x: (view.frame.width - width *  0.9) / 2, y: (view.frame.height - height + 30) / 2, width: width * 0.9, height: height)
        finalCardFrame = CGRect(x: (view.frame.width - width *  0.8) / 2, y: (view.frame.height - height + 60) / 2, width: width * 0.8, height: height)
        [initialCardFrame, intermediateCardFrame, finalCardFrame].forEach { frame in
    
            let view = CardView(frame: frame!)
       //     view.addGestureRecognizer(panGesture)
            view.alpha = alpha
            view.layer.zPosition = alpha
            alpha = alpha / 2
            self.views.append(view)
            self.view.addSubview(view)
            addTargetAllButtons(view: view)
        }
        view.bringSubviewToFront(views[0])
        views[0].isUserInteractionEnabled = true
    }
    fileprivate func addTargetAllButtons(view : CardView) {
        view.optionA.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionB.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionC.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.optionD.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    @objc func buttonTapped(sender: UIButton) {
        
        print(sender.titleLabel?.text)
        
        sender.backgroundColor = .green
        let initialView = self.views[0]
        UIView.animate(withDuration: 0.5) {
            self.removeCard(view: initialView)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 2) {
            switch self.questionCount {
            case 1:
                print("Do something")
            case 2:
                self.handleFirstCardFrame()
            case 3:
                self.handleFirstCardFrame()
                self.handleSecondCardFrame()
            default:
                self.handleFirstCardFrame()
                self.handleSecondCardFrame()
                self.createNewView()
            }
            self.view.isUserInteractionEnabled = true
        }
    }
    fileprivate func removeCard(view: UIView) {
        view.alpha = 0
        view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -4)
        view.frame = CGRect(x: view.frame.minX * 5, y: view.frame.minY, width: self.width, height: self.height)
        self.views.removeFirst()
        self.view.willRemoveSubview(view)
        self.questionCount -= 1
    }
    fileprivate func createNewView() {
        let newView = CardView(frame: self.finalCardFrame)
        newView.alpha = 0
        newView.configureViewWhenCreated(isUserInteractionEnable: false, alpha: 0.25, zPosition: 0.25)
        self.view.addSubview(newView)
        self.views.append(newView)
        addTargetAllButtons(view: newView)
    }
    fileprivate func handleFirstCardFrame() {
        let firstView = self.views[0]
        firstView.setupCardViews(frame: self.initialCardFrame, isUserInteractionEnable: true)
    }
    fileprivate func handleSecondCardFrame() {
        let secondView = self.views[1]
        secondView.setupCardViews(frame: self.intermediateCardFrame, isUserInteractionEnable: false)
    }
}

