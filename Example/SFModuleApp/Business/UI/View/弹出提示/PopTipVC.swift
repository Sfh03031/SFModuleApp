//
//  PopTipVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import AMPopTip
import UIKit

class PopTipVC: BaseViewController {
    enum ButtonType: Int {
        case center, topLeft, topRight, bottomLeft, bottomRight
    }
    
    let popTip = PopTip()
    var direction = PopTipDirection.up
    var topRightDirection = PopTipDirection.down
    var timer: Timer? = nil
    var autolayoutView: UIView?

    let /* Rival Sons's Tied Up */ lyrics = [
        "Go to the dark side full moon",
        "You shoot the apple off of my head",
        "'Cause your love, sweet love, is all that you put me through",
        "And honey without it you know I'd rather be dead",
        "I'm tied up",
        "I'm tangled up",
        "And I'm all wrapped up",
        "In you"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        popTip.font = UIFont(name: "Avenir-Medium", size: 12)!
        popTip.shouldDismissOnTap = true
        popTip.shouldDismissOnTapOutside = true
        popTip.shouldDismissOnSwipeOutside = true
        popTip.shouldConsiderCutoutTapSeparately = true
        popTip.edgeMargin = 5
        popTip.offset = 2
        popTip.bubbleOffset = 0
        popTip.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        /*
          Other customization:
         */
        //    popTip.borderWidth = 2
        //    popTip.borderColor = UIColor.blue
        //    popTip.shadowOpacity = 0.4
        //    popTip.shadowRadius = 3
        //    popTip.shadowOffset = CGSize(width: 1, height: 1)
        //    popTip.shadowColor = .black
        
//        popTip.actionAnimation = .bounce(8)
//        popTip.actionAnimation = .pulse(1.1)
//        popTip.actionAnimation = .float(offsetX: 10, offsetY: 10)
        popTip.actionAnimation = .none
        
        popTip.tapHandler = { _ in
            print("tap")
        }

        popTip.tapOutsideHandler = { _ in
            print("tap outside")
        }
        
        popTip.tapCutoutHandler = { _ in
            print("tap cutout")
        }

        popTip.swipeOutsideHandler = { _ in
            print("swipe outside")
        }

        popTip.dismissHandler = { _ in
            print("dismiss")
        }
        
        autolayoutView = Bundle.main.loadNibNamed(String(describing: AutolayoutView.self), owner: self, options: nil)?.first as? UIView
        autolayoutView?.frame.size = CGSize(width: 180, height: 100)
    }

    var swiftUIView = false
    var showSwiftUIView = false
    var showMaskAndCutout = false
    
    @IBAction func action(_ sender: UIButton) {
        guard let button = ButtonType(rawValue: sender.tag) else { return }
        
        timer?.invalidate()
        
        popTip.arrowRadius = 0
        
        switch button {
        case .topRight:
            showMaskAndCutout.toggle()
            popTip.shouldShowMask = showMaskAndCutout
            popTip.shouldCutoutMask = showMaskAndCutout
        default:
            popTip.shouldShowMask = false
            popTip.shouldCutoutMask = false
        }
        
        popTip.bubbleLayerGenerator = { path in
            guard button == .bottomLeft else { return nil } // Only use bubbleLayer when button is bottomLeft
          
            let gradient = CAGradientLayer()
            gradient.frame = path.bounds
            gradient.colors = [UIColor.black.withAlphaComponent(0.6).cgColor, UIColor.black.withAlphaComponent(0.2).cgColor]
            gradient.locations = [0, 1]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            let shapeMask = CAShapeLayer()
            shapeMask.path = path.cgPath
            gradient.mask = shapeMask
          
            return gradient
        }
        
        switch button {
        case .topLeft:
            popTip.bubbleColor = UIColor(red: 0.95, green: 0.65, blue: 0.21, alpha: 1)
            popTip.cornerRadius = 10
            if !showSwiftUIView {
                let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
                let imageView = UIImageView(image: UIImage(named: "tab_bar_icon"))
                imageView.frame = CGRect(x: (80 - imageView.frame.width) / 2, y: 0, width: imageView.frame.width, height: imageView.frame.height)
                customView.addSubview(imageView)
                let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height, width: 80, height: 120 - imageView.frame.height))
                label.numberOfLines = 0
                label.text = "This is a custom view"
                label.textAlignment = .center
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 12)
                customView.addSubview(label)
            
                popTip.show(customView: customView, direction: .auto, in: view, from: sender.frame)
            } else if #available(iOS 13.0.0, *) {
                #if canImport(SwiftUI) && canImport(Combine)
                if swiftUIView {
                    popTip.show(rootView: SwiftUIOneView(), direction: .down, in: view, from: sender.frame, parent: self)
                } else {
                    popTip.show(rootView: SwiftUITwoView(), direction: .down, in: view, from: sender.frame, parent: self)
                }
                self.swiftUIView.toggle()
                #endif
            }
            popTip.entranceAnimationHandler = { [weak self] completion in
                guard let `self` = self else { return }
                self.popTip.transform = CGAffineTransform(rotationAngle: 0.3)
                UIView.animate(withDuration: 0.5, animations: {
                    self.popTip.transform = .identity
                }, completion: { _ in
                    completion()
                })
            }
            if #available(iOS 13.0.0, *) {
                self.showSwiftUIView.toggle()
            }

        case .topRight:
            popTip.bubbleColor = UIColor(red: 0.97, green: 0.9, blue: 0.23, alpha: 1)
            if topRightDirection == .left {
                topRightDirection = .down
            } else {
                topRightDirection = .left
            }
            popTip.show(text: "I have an offset to move the bubble down or left side.", direction: .autoHorizontal, maxWidth: 150, in: view, from: sender.frame)
          
        case .bottomLeft:
            popTip.bubbleColor = UIColor(red: 0.73, green: 0.91, blue: 0.55, alpha: 1)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.random
            ]
            
            let underline: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.white,
                .underlineStyle: NSUnderlineStyle.styleSingle.rawValue
            ]
            
            let attributedText = NSMutableAttributedString(string: "I'm presenting a string ", attributes: attributes)
            attributedText.append(NSAttributedString(string: "with attributes!", attributes: underline))
            attributedText.append(NSAttributedString(string: " And custom background!", attributes: attributes))
            popTip.show(attributedText: attributedText, direction: .up, maxWidth: 200, in: view, from: sender.frame)
          
        case .bottomRight:
            popTip.bubbleColor = UIColor(red: 0.81, green: 0.04, blue: 0.14, alpha: 1)
            //      popTip.show(text: "Animated popover, great for subtle UI tips and onboarding", direction: .left, maxWidth: 200, in: view, from: sender.frame)
            popTip.show(customView: autolayoutView!, direction: .left, in: view, from: sender.frame)
          
        case .center:
            popTip.arrowRadius = 2
            popTip.bubbleColor = UIColor(red: 0.31, green: 0.57, blue: 0.87, alpha: 1)
            popTip.show(text: "Animated popover, great for subtle UI tips and onboarding", direction: direction, maxWidth: 200, in: view, from: sender.frame)
            direction = direction.cycleDirection()
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                self.popTip.update(text: self.lyrics.sample())
            }
        }
    }
}

extension PopTipDirection {
    func cycleDirection() -> PopTipDirection {
        switch self {
        case .auto:
            return .auto
        case .autoVertical:
            return .autoVertical
        case .autoHorizontal:
            return .autoHorizontal
        case .up:
            return .right
        case .right:
            return .down
        case .down:
            return .left
        case .left:
            return .up
        case .none:
            return .none
        }
    }
}

extension Array {
    func sample() -> Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}
