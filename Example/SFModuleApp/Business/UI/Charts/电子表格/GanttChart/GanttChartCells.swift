//
//  GanttChartCells.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SpreadsheetView

class HeaderCell1: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TextCell1: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TaskCell: Cell {
    let label = UILabel()

    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 0

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ChartBarCell: Cell {
    let colorBarView = UIView()
    let label = UILabel()

    var color: UIColor = .clear {
        didSet {
            colorBarView.backgroundColor = color
        }
    }

    override var frame: CGRect {
        didSet {
            colorBarView.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(colorBarView)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
