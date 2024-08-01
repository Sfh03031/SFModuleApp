//
//  AlignedCollectionViewFlowLayoutVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PopMenu
import SFStyleKit
import UIFontComplete
import AlignedCollectionViewFlowLayout

class AlignedCollectionViewFlowLayoutVC: BaseViewController {

    let tags1 = ["When you", "eliminate", "the impossible,", "whatever remains,", "however improbable,", "must be", "the truth."]
    let tags2 = ["Of all the souls", "I have", "encountered", "in my travels,", "his", "was the most…", "human."]
    let tags3 = ["Computers", "make", "excellent", "and", "efficient", "servants", "but", "I", "have", "no", "wish", "to", "serve", "under", "them."]
    
    var dataSource: [[String]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img_right = SFSymbol.symbol(name: "list.star", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img_right!, style: .plain, target: self, action: #selector(rightTap(_:)))

        collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
        self.view.addSubview(collectionView)
        
        dataSource = [tags1, tags2, tags3]
        
        self.collectionView.reloadData()
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        let manager = PopMenuManager.default
        manager.actions = [
            PopMenuDefaultAction(title: "H-left,V-top", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
            PopMenuDefaultAction(title: "H-left,V-center", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
            PopMenuDefaultAction(title: "H-left,V-bottom", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
            PopMenuDefaultAction(title: "H-justified,V-top", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
            PopMenuDefaultAction(title: "H-justified,V-center", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
            PopMenuDefaultAction(title: "H-justified,V-bottom", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
            PopMenuDefaultAction(title: "H-right,V-top", image: SFSymbol.symbol(name: "figure.walk.motion"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
            PopMenuDefaultAction(title: "H-right,V-center", image: SFSymbol.symbol(name: "paragraphsign"), color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
            PopMenuDefaultAction(title: "H-right,V-bottom", image: SFSymbol.symbol(name: "crop.rotate"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        ]
        manager.popMenuAppearance.popMenuFont = UIFont.init(font: .kohinoorBanglaSemibold , size: 16)!
        manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
        manager.popMenuShouldDismissOnSelection = true
        manager.popMenuDelegate = self
        manager.present(sourceView: sender)
        
    }
    
    //MARK: - lazyload
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .hex_F5F6F9
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AnimatedLayoutCell.self, forCellWithReuseIdentifier: String(describing: AnimatedLayoutCell.self))
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    lazy var collectionViewLayout: AlignedCollectionViewFlowLayout = {
        let layout = AlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = .init(width: (SCREENW - 200) / 2, height: 150)
        layout.sectionInset = UIEdgeInsets(all: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
//        layout.scrollDirection = .vertical
        layout.horizontalAlignment = .left
        layout.verticalAlignment = .top
        return layout
    }()

}

extension AlignedCollectionViewFlowLayoutVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AnimatedLayoutCell.self), for: indexPath) as! AnimatedLayoutCell
    
        cell.backgroundColor = .alizarin
        cell.label.text = dataSource[indexPath.section][indexPath.item]
        cell.label.font = UIFont.init(font: Font.menloBoldItalic, size: 14.0)!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let value = dataSource[indexPath.section][indexPath.item]
        let size = value.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)),
                                        options: .usesLineFragmentOrigin,
                                        attributes: [.font: UIFont.init(font: Font.menloBoldItalic, size: 14.0)!],
                                        context: nil).size
        let offset = indexPath.item % 2 == 0 ? 20.0 : (indexPath.item % 3 == 0 ? 30.0 : 40.0)
        return CGSize(width: size.width + 20, height: size.height + offset)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            header.backgroundColor = .white
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
}

// MARK: - PopMenuViewControllerDelegate
extension AlignedCollectionViewFlowLayoutVC: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
//        let HList:[HorizontalAlignment] = [.left, .justified, .right]
//        let VList:[VerticalAlignment] = [.top, .center, .bottom]
//        
//        if index < 3 {
//            self.collectionViewLayout.scrollDirection = .vertical
//            self.collectionViewLayout.horizontalAlignment = HList[index]
//        } else {
//            self.collectionViewLayout.scrollDirection = .horizontal
//            self.collectionViewLayout.verticalAlignment = VList[index - 3]
//        }
        
        switch index {
        case 0:
            self.collectionViewLayout.horizontalAlignment = .left
            self.collectionViewLayout.verticalAlignment = .top
        case 1:
            self.collectionViewLayout.horizontalAlignment = .left
            self.collectionViewLayout.verticalAlignment = .center
        case 2:
            self.collectionViewLayout.horizontalAlignment = .left
            self.collectionViewLayout.verticalAlignment = .bottom
        case 3:
            self.collectionViewLayout.horizontalAlignment = .justified
            self.collectionViewLayout.verticalAlignment = .top
        case 4:
            self.collectionViewLayout.horizontalAlignment = .justified
            self.collectionViewLayout.verticalAlignment = .center
        case 5:
            self.collectionViewLayout.horizontalAlignment = .justified
            self.collectionViewLayout.verticalAlignment = .bottom
        case 6:
            self.collectionViewLayout.horizontalAlignment = .right
            self.collectionViewLayout.verticalAlignment = .top
        case 7:
            self.collectionViewLayout.horizontalAlignment = .right
            self.collectionViewLayout.verticalAlignment = .center
        case 8:
            self.collectionViewLayout.horizontalAlignment = .right
            self.collectionViewLayout.verticalAlignment = .bottom
        default:
            break
        }
        
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.reloadData()
    }
    
}
