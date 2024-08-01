//
//  VerticalCardSwiperVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import VerticalCardSwiper

internal class Contact {

    let name: String!
    let age: Int!

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class VerticalCardSwiperVC: BaseViewController {
    
    private var dataList: [Contact] = [
        Contact(name: "John Doe", age: 33),
        Contact(name: "Chuck Norris", age: 78),
        Contact(name: "Bill Gates", age: 62),
        Contact(name: "Steve Jobs", age: 56),
        Contact(name: "Barack Obama", age: 56),
        Contact(name: "Mila Kunis", age: 34),
        Contact(name: "Pamela Anderson", age: 50),
        Contact(name: "Christina Anguilera", age: 37),
        Contact(name: "Ed Sheeran", age: 23),
        Contact(name: "Jennifer Lopez", age: 45),
        Contact(name: "Nicki Minaj", age: 31),
        Contact(name: "Tim Cook", age: 57),
        Contact(name: "Satya Nadella", age: 50)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 禁掉左滑返回
        let traget = self.navigationController?.interactivePopGestureRecognizer?.delegate;
        let pan = UIPanGestureRecognizer.init(target: traget, action: nil)
        self.view.addGestureRecognizer(pan)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: downBtn),
            UIBarButtonItem(customView: upBtn),
            UIBarButtonItem(customView: rightBtn),
            UIBarButtonItem(customView: leftBtn),
            UIBarButtonItem(customView: addBtn),
            UIBarButtonItem(customView: reduceBtn),
        ]

        cardSwiper.isSideSwipingEnabled = true
        cardSwiper.topInset = 40
        cardSwiper.sideInset = 20
        cardSwiper.visibleNextCardHeight = 50
        cardSwiper.cardSpacing = 40
        cardSwiper.firstItemTransform = 0.05
        cardSwiper.isStackingEnabled = true
        cardSwiper.isStackOnBottom = true
        cardSwiper.stackedCardsCount = 2
        self.view.addSubview(cardSwiper)
        
    }
    
    //MARK: - click event
    
    @objc func reduce(_ sender: UIButton) {
        var indexesToRemove: [Int] = []
        for i in (0...4).reversed() where i < dataList.count {
            dataList.remove(at: i)
            indexesToRemove.append(i)
        }
        cardSwiper.deleteCards(at: indexesToRemove)
    }
    
    @objc func add(_ sender: UIButton) {
        let c1 = Contact(name: "testUser1", age: 12)
        let c2 = Contact(name: "testUser2", age: 12)
        let c3 = Contact(name: "testUser3", age: 12)
        let c4 = Contact(name: "testUser4", age: 12)
        let c5 = Contact(name: "testUser5", age: 12)
        dataList.insert(c1, at: 0)
        dataList.insert(c2, at: 1)
        dataList.insert(c3, at: 2)
        dataList.insert(c4, at: 3)
        dataList.insert(c5, at: 4)

        cardSwiper.insertCards(at: [0, 1, 2, 3, 4])
    }
    
    @objc func left(_ sender: UIButton) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Left)
        }
    }
    
    @objc func right(_ sender: UIButton) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Right)
        }
    }
    
    @objc func up(_ sender: UIButton) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex - 1, animated: true)
        }
    }
    
    @objc func down(_ sender: UIButton) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex + 1, animated: true)
        }
    }
    
    //MARK: - lazyload
    
    lazy var cardSwiper: VerticalCardSwiper = {
        let view = VerticalCardSwiper(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight))
        view.backgroundColor = .hex_F5F6F9
        view.delegate = self
        view.datasource = self
        view.register(VCSCell.self, forCellWithReuseIdentifier: "VCSCell")
        return view
    }()

    lazy var reduceBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("-5", for: .normal)
        btn.setTitleColor(.systemTeal, for: .normal)
        btn.addTarget(self, action: #selector(reduce(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("+5", for: .normal)
        btn.setTitleColor(.systemTeal, for: .normal)
        btn.addTarget(self, action: #selector(add(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var leftBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(SFSymbol.symbol(name: "chevron.left", tintColor: .systemTeal), for: .normal)
        btn.addTarget(self, action: #selector(left(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(SFSymbol.symbol(name: "chevron.right", tintColor: .systemTeal), for: .normal)
        btn.addTarget(self, action: #selector(right(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var upBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(SFSymbol.symbol(name: "chevron.up", tintColor: .systemTeal), for: .normal)
        btn.addTarget(self, action: #selector(up(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var downBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(SFSymbol.symbol(name: "chevron.down", tintColor: .systemTeal), for: .normal)
        btn.addTarget(self, action: #selector(down(_:)), for: .touchUpInside)
        return btn
    }()
}


extension VerticalCardSwiperVC: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        dataList.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "VCSCell", for: index) as? VCSCell {

            let contact = dataList[index]
            cardCell.nameLabel.text = "Name: " + contact.name
            cardCell.ageLabel.text = "Age: \(contact.age ?? 0)"
            return cardCell
        }
        return CardCell()
    }
    
    /// called right before the card animates off the screen.
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        if index < dataList.count {
            dataList.remove(at: index)
        }
    }

    /// called when a card has animated off screen entirely.
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
    }
}
