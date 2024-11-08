//
//  FontsVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import UIFontComplete
import HandyJSON

class FontsVC: BaseViewController {
    
    var dataList: [FontModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(collectionView)
        
        let list = [
            ["name": "ONLY Available in iOS 13+", "list": [UIFontComplete.Font.appleSymbols,.charterBlackItalic,.charterBold,.charterRoman,.charterBlack,.charterBoldItalic,.charterItalic,.dINAlternateBold,.dINCondensedBold,.galvjiBold,.galvji, .hiraginoSansW7, .kohinoorGujaratiLight, .kohinoorGujaratiBold, .kohinoorGujaratiRegular, .muktaMaheeLight, .muktaMaheeBold, .muktaMaheeRegular, .notoNastaliqUrduBold, .notoSansKannadaBold, .notoSansKannadaLight, .notoSansKannadaRegular, .notoSansMyanmarRegular, .notoSansMyanmarBold, .notoSansMyanmarLight, .notoSansOriyaBold, .notoSansOriya, .rockwellItalic, .rockwellRegular, .rockwellBold, .rockwellBoldItalic]],
            ["name": "Academy Engraved LET", "list": [UIFontComplete.Font.academyEngravedLetPlain]],
            ["name": "Al Nile", "list": [UIFontComplete.Font.alNile, UIFontComplete.Font.alNileBold]],
            ["name": "American Typewriter", "list": [UIFontComplete.Font.americanTypewriter, .americanTypewriterBold, .americanTypewriterCondensed, .americanTypewriterCondensedBold, .americanTypewriterCondensedLight, .americanTypewriterLight, .americanTypewriterSemibold]],
            ["name": "Apple Color Emoji", "list": [UIFontComplete.Font.appleColorEmoji]],
            ["name": "Apple SD Gothic Neo", "list": [UIFontComplete.Font.appleSDGothicNeoBold, .appleSDGothicNeoLight, .appleSDGothicNeoMedium, .appleSDGothicNeoRegular, .appleSDGothicNeoSemiBold, .appleSDGothicNeoThin, .appleSDGothicNeoUltraLight]],
            ["name": "Arial", "list": [UIFontComplete.Font.arialMT, .arialBoldItalicMT, .arialBoldMT, .arialItalicMT]],
            ["name": "Arial Hebrew", "list": [UIFontComplete.Font.arialHebrew, .arialHebrewBold, .arialHebrewLight]],
            ["name": "Arial Rounded MT Bold", "list": [UIFontComplete.Font.arialRoundedMTBold]],
            ["name": "Avenir", "list": [UIFontComplete.Font.avenirBlack, .avenirBlackOblique, .avenirBook, .avenirBookOblique, .avenirHeavy, .avenirHeavyOblique, .avenirLight, .avenirLightOblique, .avenirMedium, .avenirMediumOblique, .avenirOblique, .avenirRoman]],
            ["name": "Avenir Next", "list": [UIFontComplete.Font.avenirNextBold, .avenirNextBoldItalic, .avenirNextDemiBold, .avenirNextDemiBoldItalic, .avenirNextHeavy, .avenirNextHeavyItalic, .avenirNextItalic, .avenirNextMedium, .avenirNextMediumItalic, .avenirNextRegular, .avenirNextUltraLight, .avenirNextUltraLightItalic]],
            ["name": "Avenir Next Condensed", "list": [UIFontComplete.Font.avenirNextCondensedBold, .avenirNextCondensedBoldItalic, .avenirNextCondensedDemiBold, .avenirNextCondensedDemiBoldItalic, .avenirNextCondensedHeavy, .avenirNextCondensedHeavyItalic, .avenirNextCondensedItalic, .avenirNextCondensedMedium, .avenirNextCondensedMediumItalic, .avenirNextCondensedRegular, .avenirNextCondensedUltraLight, .avenirNextCondensedUltraLightItalic]],
            ["name": "Baskerville", "list": [UIFontComplete.Font.baskerville, .baskervilleBold, .baskervilleBoldItalic, .baskervilleItalic, .baskervilleSemiBold, .baskervilleSemiBoldItalic]],
            ["name": "Bodoni 72", "list": [UIFontComplete.Font.bodoniSvtyTwoITCTTBold, .bodoniSvtyTwoITCTTBook, .bodoniSvtyTwoITCTTBookIta]],
            ["name": "Bodoni 72 Oldstyle", "list": [UIFontComplete.Font.bodoniSvtyTwoOSITCTTBold, .bodoniSvtyTwoOSITCTTBook, .bodoniSvtyTwoOSITCTTBookIt]],
            ["name": "Bodoni 72 Smallcaps", "list": [UIFontComplete.Font.bodoniSvtyTwoSCITCTTBook]],
            ["name": "Bodoni Ornaments", "list": [UIFontComplete.Font.bodoniOrnamentsITCTT]],
            ["name": "Bradley Hand", "list": [UIFontComplete.Font.bradleyHandITCTTBold]],
            ["name": "Chalkboard SE", "list": [UIFontComplete.Font.chalkboardSEBold, .chalkboardSELight, .chalkboardSERegular]],
            ["name": "Chalkduster", "list": [UIFontComplete.Font.chalkduster]],
            ["name": "Cochin", "list": [UIFontComplete.Font.cochin, .cochinBold, .cochinBoldItalic, .cochinItalic]],
            ["name": "Copperplate", "list": [UIFontComplete.Font.copperplate, .copperplateBold, .copperplateLight]],
            ["name": "Courier", "list": [UIFontComplete.Font.courier, .courierBold, .courierBoldOblique, .courierOblique]],
            ["name": "Courier New", "list": [UIFontComplete.Font.courierNewPSMT, .courierNewPSBoldMT, .courierNewPSBoldItalicMT, .courierNewPSItalicMT]],
            ["name": "Damascus", "list": [UIFontComplete.Font.damascus, .damascusBold, .damascusLight, .damascusMedium, .damascusSemiBold]],
            ["name": "Devanagari Sangam MN", "list": [UIFontComplete.Font.devanagariSangamMN, .devanagariSangamMNBold]],
            ["name": "Didot", "list": [UIFontComplete.Font.didot, .didotBold, .didotItalic]],
            ["name": "Diwan Mishafi", "list": [UIFontComplete.Font.diwanMishafi]],
            ["name": "Euphemia UCAS", "list": [UIFontComplete.Font.euphemiaUCAS, .euphemiaUCASBold, .euphemiaUCASItalic]],
            ["name": "Farah", "list": [UIFontComplete.Font.farah]],
            ["name": "Futura", "list": [UIFontComplete.Font.futuraBold, .futuraCondensedExtraBold, .futuraCondensedMedium, .futuraMedium, .futuraMediumItalic]],
            ["name": "Geeza Pro", "list": [UIFontComplete.Font.geezaPro, .geezaProBold]],
            ["name": "Georgia", "list": [UIFontComplete.Font.georgia, .georgiaBold, .georgiaBoldItalic, .georgiaItalic]],
            ["name": "Gill Sans", "list": [UIFontComplete.Font.gillSans, .gillSansBold, .gillSansBoldItalic, .gillSansItalic, .gillSansLight, .gillSansLightItalic, .gillSansSemiBold, .gillSansSemiBoldItalic, .gillSansUltraBold]],
            ["name": "Helvetica", "list": [UIFontComplete.Font.helvetica, .helveticaBold, .helveticaBoldOblique, .helveticaLight, .helveticaLightOblique, .helveticaOblique]],
            ["name": "Helvetica Neue", "list": [UIFontComplete.Font.helveticaNeue, .helveticaNeueCondensedBlack, .helveticaNeueCondensedBold, .helveticaNeueBold, .helveticaNeueBoldItalic, .helveticaNeueItalic, .helveticaNeueLight, .helveticaNeueLightItalic, .helveticaNeueMedium, .helveticaNeueMediumItalic, .helveticaNeueThin, .helveticaNeueThinItalic, .helveticaNeueUltraLight, .helveticaNeueUltraLightItalic]],
            ["name": "Hiragino Mincho ProN", "list": [UIFontComplete.Font.hiraMinProNW3, .hiraMinProNW6, .hiraMaruProNW4]],
            ["name": "Hiragino Sans", "list": [UIFontComplete.Font.hiraginoSansW3, .hiraginoSansW6]],
            ["name": "Hoefler Text", "list": [UIFontComplete.Font.hoeflerTextBlack, .hoeflerTextBlackItalic, .hoeflerTextItalic, .hoeflerTextRegular]],
            ["name": "Kailasa", "list": [UIFontComplete.Font.kailasa, .kailasaBold]],
            ["name": "Kefa", "list": [UIFontComplete.Font.kefaRegular]],
            ["name": "Khmer Sangam MN", "list": [UIFontComplete.Font.khmerSangamMN]],
            ["name": "Kohinoor Bangla", "list": [UIFontComplete.Font.kohinoorBanglaLight, .kohinoorBanglaRegular, .kohinoorBanglaSemibold]],
            ["name": "Kohinoor Devanagari", "list": [UIFontComplete.Font.kohinoorDevanagariLight, .kohinoorDevanagariRegular, .kohinoorDevanagariSemibold]],
            ["name": "Kohinoor Telugu", "list": [UIFontComplete.Font.kohinoorTeluguLight, .kohinoorTeluguMedium, .kohinoorTeluguRegular]],
            ["name": "Lao Sangam MN", "list": [UIFontComplete.Font.laoSangamMN]],
            ["name": "Malayalam Sangam MN", "list": [UIFontComplete.Font.malayalamSangamMN, .malayalamSangamMNBold]],
            ["name": "Marker Felt", "list": [UIFontComplete.Font.markerFeltThin, .markerFeltWide]],
            ["name": "Menlo", "list": [UIFontComplete.Font.menloBold, .menloBoldItalic, .menloItalic, .menloRegular]],
            ["name": "Myanmar Sangam MN", "list": [UIFontComplete.Font.myanmarSangamMN, .myanmarSangamMNBold]],
            ["name": "Noteworthy", "list": [UIFontComplete.Font.noteworthyBold, .noteworthyLight]],
            ["name": "Noto Nastaliq Urdu", "list": [UIFontComplete.Font.notoNastaliqUrdu]],
            ["name": "Optima", "list": [UIFontComplete.Font.optimaBold, .optimaBoldItalic, .optimaExtraBlack, .optimaItalic, .optimaRegular]],
            ["name": "Palatino", "list": [UIFontComplete.Font.palatinoBold, .palatinoBoldItalic, .palatinoItalic, .palatinoRoman]],
            ["name": "Papyrus", "list": [UIFontComplete.Font.papyrus, .papyrusCondensed]],
            ["name": "Party LET", "list": [UIFontComplete.Font.partyLetPlain]],
            ["name": "PingFang HK", "list": [UIFontComplete.Font.pingFangHKLight, .pingFangHKMedium, .pingFangHKRegular, .pingFangHKSemibold, .pingFangHKThin, .pingFangHKUltralight]],
            ["name": "PingFang SC", "list": [UIFontComplete.Font.pingFangSCLight, .pingFangSCMedium, .pingFangSCRegular, .pingFangSCSemibold, .pingFangSCThin, .pingFangSCUltralight]],
            ["name": "PingFang TC", "list": [UIFontComplete.Font.pingFangTCLight, .pingFangTCMedium, .pingFangTCRegular, .pingFangTCSemibold, .pingFangTCThin, .pingFangTCUltralight]],
            ["name": "Savoye LET", "list": [UIFontComplete.Font.savoyeLetPlain]],
            ["name": "Sinhala Sangam MN", "list": [UIFontComplete.Font.sinhalaSangamMN, .sinhalaSangamMNBold]],
            ["name": "Snell Roundhand", "list": [UIFontComplete.Font.snellRoundhand, .snellRoundhandBlack, .snellRoundhandBold]],
            ["name": "Symbol", "list": [UIFontComplete.Font.symbol]],
            ["name": "Tamil Sangam MN", "list": [UIFontComplete.Font.tamilSangamMN, .tamilSangamMNBold]],
            ["name": "Thonburi", "list": [UIFontComplete.Font.thonburi, .thonburiBold, .thonburiLight]],
            ["name": "Times New Roman", "list": [UIFontComplete.Font.timesNewRomanPSBoldMT, .timesNewRomanPSBoldItalicMT, .timesNewRomanPSItalicMT, .timesNewRomanPSMT]],
            ["name": "Trebuchet MS", "list": [UIFontComplete.Font.trebuchetMS, .trebuchetMSBold, .trebuchetBoldItalic, .trebuchetMSItalic]],
            ["name": "Verdana", "list": [UIFontComplete.Font.verdana, .verdanaBold, .verdanaBoldItalic, .verdanaItalic]],
            ["name": "Zapf Dingbats", "list": [UIFontComplete.Font.zapfDingbatsITC]],
            ["name": "Zapfino", "list": [UIFontComplete.Font.zapfino]],
        ]
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<FontModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        self.collectionView.reloadData()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
    }
    
    //MARK: - lazyload
    
    //collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSizeMake((SCREENW - 30)/2, 80)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10

        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.backgroundColor = .hex_F5F6F9
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(FontCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FontCollectionViewCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FontsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList[section].list!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FontCollectionViewCell.self), for: indexPath) as! FontCollectionViewCell
        
        cell.font = self.dataList[indexPath.section].list?[indexPath.item] as? UIFontComplete.Font ?? .alNile
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 50), bgColor: .systemBackground, text: self.dataList[indexPath.section].name ?? "", textColor: .label, font: UIFont.systemFont(ofSize: 16, weight: .medium), aligment: .center)
            header.addSubview(label)
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
}
