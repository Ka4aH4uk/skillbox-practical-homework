//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var fishes = [UIImageView]()
    var fishCount = 0
    
    var isFishCatched = false {
        didSet {
            animateButton()
        }
    }
    
    lazy var fish1: UIImageView = {
        let image = UIImage(named: "fish")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var fish2: UIImageView = {
        let image = UIImage(named: "fish2")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var fish3: UIImageView = {
        let image = UIImage(named: "fish3")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var fish4: UIImageView = {
        let image = UIImage(named: "fish4")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var fish5: UIImageView = {
        let image = UIImage(named: "fish5")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var pointLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.view.center.x, y: 695, width: 300, height: 50))
        label.textAlignment = .center
        label.center.x = self.view.center.x
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 24)
        label.textColor = .white
        label.text = "Поймано рыбов 🎣: \(fishCount)"
        return label
    }()
    
    private lazy var button: UIButton = {
        UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.isFishCatched = !self.isFishCatched
            self.pointLabel.text = "Поймано рыбов 🎣: \(self.fishCount)"
            print("Button tapped!")
        }))
    }()
    
    private var constraintsToAnimate: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fishes = [fish1, fish2, fish3, fish4, fish5]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        button.addTarget(self, action: #selector(self.startFishing(sender:)), for: .touchUpInside)
        
        setupViews()
        setupConstraintsButton()
        randomeMove()
    }
    
    func setupViews() {
        view.addSubview(fish1)
        view.addSubview(fish2)
        view.addSubview(fish3)
        view.addSubview(fish4)
        view.addSubview(fish5)
        view.addSubview(pointLabel)
        view.addSubview(button)
    }
    
    func setupConstraintsButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraints = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraints = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 360)
        let widthContsraints = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let heightContsraints = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        
        constraintsToAnimate = heightContsraints
        
        view.addConstraints([horizontalConstraints, verticalConstraints, widthContsraints, heightContsraints])
    }

    @objc func startFishing(sender: UIButton) {
        fishes.append(contentsOf: [fish1, fish2, fish3, fish4, fish5])
        fishes.forEach { fish in
            isFishCatched = true
            fish.frame = CGRect(x: Int.random(in: 20...350), y: Int.random(in: 50...600), width: Int.random(in: 100...150), height: Int.random(in: 100...150))
            fish.alpha = 1.0
            fish.contentMode = .scaleAspectFit
            view.addSubview(fish)
        }
        randomeMove()
    }
    
    func randomeMove() {
        let randomizer = Int.random(in: 1...4)
        switch randomizer {
        case 1: moveLeft()
        case 2: moveRight()
        case 3: moveTop()
        case 4: moveBottom()
        default:
            print("На дне")
        }
    }
        
    func moveLeft() {
        //        if isFishCatched { return }
        UIImageView.animate(withDuration: 2.0,
                            delay: 2.0,
                            options: [.curveEaseInOut , .allowUserInteraction],
                            animations: {
            self.fish1.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish2.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish3.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish4.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish5.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
        },
                            completion: { finished in
            self.moveRight()
            print("fish moved left!")
        })
    }
    
    func moveRight() {
//        if isFishCatched { return }
        UIView.animate(withDuration: 2.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish1.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish2.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish3.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish4.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish5.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
        },
                       completion: { finished in
            self.moveTop()
            print("fish moved right!")
        })
    }
    
    func moveTop() {
//        if isFishCatched { return }
        UIView.animate(withDuration: 2.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish1.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish2.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish3.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish4.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish5.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
        },
                       completion: { finished in
            self.moveBottom()
            print("fish moved top!")
        })
    }
    
    func moveBottom() {
        //        if isFishCatched { return }
        UIView.animate(withDuration: 2.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish1.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish2.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish3.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish4.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
            self.fish5.center = CGPoint(x: Int.random(in: 20...350), y: Int.random(in: 70...600))
        },
                       completion: { finished in
            self.moveLeft()
            print("fish moved bottom!")
        })
    }

    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        fishes = fishes.filter { fish in
            let tapLocation = gesture.location(in: fish.superview)
            if (fish.layer.presentation()?.frame.contains(tapLocation))! {
                print("fish tapped!")
                if isFishCatched { return true }
                fishCatchedAnimation(fish)
                fishCount += 1
                pointLabel.text = "Поймано рыбов 🎣: \(fishCount)"
                if fishCount == 5 {
                    pointLabel.text = "Все рыбов пойманы!🎉"
                    print("Все рыбов пойманы!")
                    fishes.removeAll()
                    fishCount = 0
                    isFishCatched = true
                }
                return false
            } else {
                return true
            }
        }
        print(fishes.count)
    }

    func fishCatchedAnimation(_ fish: UIImageView) {
        UIView.animate(withDuration: 2.0,
                       delay: 0.5,
                       options: [.curveEaseIn , .allowUserInteraction],
                       animations: {
            fish.center = CGPoint(x: 0, y: 0)
            fish.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            fish.alpha = 0.0
        },
                       completion: { finished in
            fish.removeFromSuperview()
            print("fish catched")
        })
    }
}

extension ViewController {
    func animateButton() {
        if isFishCatched {
            button.layer.cornerRadius = self.button.frame.size.width / 2
            constraintsToAnimate.constant = 90
            UIButton.animate(withDuration: 1.0, animations: {
                self.button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.button.alpha = 1.0
                self.button.setTitle("Restart", for: .normal)
                self.button.backgroundColor = .red
                self.button.tintColor = .white
                self.button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
                self.button.layer.cornerRadius = self.button.frame.size.width / 2
            })
        } else {
            button.layoutIfNeeded()
            constraintsToAnimate.constant = 90
            UIButton.animate(withDuration: 1.0,
                             delay: 0.5,
                             options: [.curveEaseIn , .allowUserInteraction],
                             animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.button.alpha = 0.0
                self.button.layoutIfNeeded()
            })
        }
    }
}
