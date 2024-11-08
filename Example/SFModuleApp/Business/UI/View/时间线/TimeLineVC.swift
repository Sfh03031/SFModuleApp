//
//  TimeLineVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit

class TimeLineVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(timeLineView)
        
        let touchAction = { (point:ISPoint) in
            print("point \(point.title)")
        }
        
        let myPoints = [
            ISPoint(title: "06:46 AM", description: "起床洗漱，空腹一杯黑咖啡。", pointColor: .hex_008AFF, lineColor: .hex_3d3b4f, touchUpInside: touchAction, fill: false),
            ISPoint(title: "07:00 AM", description: "骑车出门，目标体育场", pointColor: .hex_008AFF, lineColor: .hex_3d3b4f, touchUpInside: touchAction, fill: false),
            ISPoint(title: "07:30 AM", description: "到达体育场，热身，之后有氧运动四十分钟。运动完毕后做拉伸，每个动作保持至少三十秒。骑行回家洗澡，准备出门上课。", pointColor: .hex_008AFF, lineColor: .hex_3d3b4f, touchUpInside: touchAction, fill: false),
            ISPoint(title: "08:30 AM", description: "到达教室，准备上午的课程", pointColor: .systemTeal, lineColor: .red, touchUpInside: touchAction, fill: true),
            ISPoint(title: "11:30 AM", description: "开始吃午饭，午间休息", touchUpInside: touchAction),
            ISPoint(title: "剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独剑指台独", description: "5月23日，东部战区发布“联合利剑—2024A”演习区域示意图，记者第一时间就示意图找到权威军事专家张弛进行解读。从示意图看大陆对台演练突破", touchUpInside: touchAction),
            ISPoint(title: "05:00 PM", description: "专家指出，从图上来看，这三个方向的意义分别在于：", touchUpInside: touchAction),
            ISPoint(title: "08:15 PM", description: "首先，在台湾岛北部进行演练，不仅是对台北政治和军事的重要目标进行威慑，而且是对民进党当局的一个敲打。", touchUpInside: touchAction),
            ISPoint(title: "11:45 PM", description: "其次，在台湾岛南部进行演练，可以从三个方面来看，一是政治上痛击“台独”的大本营，我们知道台南是“台独”势力的大本营。二是经济上对台湾岛进行封锁。邻近台湾岛南部的高雄港，是台湾的第一大港，因此演习具有掐住高雄港这一台湾海上门户，沉重打击台湾对外贸易的意味。三是军事上，高雄港是台湾海军重要驻扎地，所以这一次演习就表明解放军能够把台湾当局的海军牢牢困在港内，是对“台独”势力“以武谋独”幻想的一个有力震慑。", touchUpInside: touchAction),
            ISPoint(title: "08:00 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.", pointColor: .random, lineColor: .random, touchUpInside: touchAction, fill: true),
            ISPoint(title: "11:30 AM", description: "最后，在台湾岛东部进行演练，是为了阻断三条线，一是阻断台湾能源进口的生命线。二是阻断“台独”势力想要逃避制裁、向外逃窜的逃跑线。三是阻断美国一些盟友向“台独”势力提供援助的支援线。", touchUpInside: touchAction),
            ISPoint(title: "02:30 PM", description: "台湾岛东部的花莲县，直面太平洋。花莲港是台湾的主要港口之一，所以这一次演习，解放军在花莲附近的海空域开展模拟打击的演练，就展示了要联合夺权、要占控要地的能力，这就表明了解放军可以从多个方向对台湾的港口、机场等重要目标进行威慑和打击。", touchUpInside: touchAction),
            ISPoint(title: "05:00 PM", description: "台湾岛东部的花莲县，直面太平洋。花莲港是台湾的主要港口之一，所以这一次演习，解放军在花莲附近的海空域开展模拟打击的演练，就展示了要联合夺权、要占控要地的能力，这就表明了解放军可以从多个方向对台湾的港口、机场等重要目标进行威慑和打击。", touchUpInside: touchAction),
            ISPoint(title: "08:15 PM", description: "台湾岛东部的花莲县，直面太平洋。花莲港是台湾的主要港口之一，所以这一次演习，解放军在花莲附近的海空域开展模拟打击的演练，就展示了要联合夺权、要占控要地的能力，这就表明了解放军可以从多个方向对台湾的港口、机场等重要目标进行威慑和打击。", touchUpInside: touchAction),
            ISPoint(title: "11:45 PM", description: "台湾岛东部的花莲县，直面太平洋。花莲港是台湾的主要港口之一，所以这一次演习，解放军在花莲附近的海空域开展模拟打击的演练，就展示了要联合夺权、要占控要地的能力，这就表明了解放军可以从多个方向对台湾的港口、机场等重要目标进行威慑和打击。", touchUpInside: touchAction),
        ]
        
        timeLineView.contentInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        timeLineView.points = myPoints
        
    }
    

    lazy var timeLineView: ISTimeline = {
        let view = ISTimeline(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight))
        view.pointDiameter = 20
        view.bubbleRadius = 5.0
        view.bubbleColor = .random
        view.bubbleArrows = true
        view.pointLineWidth = 2.0
        view.lineWidth = 5.0
        view.titleColor = .white
        view.titleFont = UIFont.boldSystemFont(ofSize: 16)
        view.descriptionColor = .random
        view.descriptionFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        return view
    }()

}
