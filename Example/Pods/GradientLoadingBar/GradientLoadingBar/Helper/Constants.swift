//
//  Constants.swift
//  GradientLoadingBar
//
//  Created by Felix Mau on 26.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import UIKit

public extension UIColor {

    // swiftlint:disable:next missing_docs
    enum GradientLoadingBar {
        /// The default color palette for the gradient colors.
        ///
        /// - SeeAlso: https://codepen.io/marcobiedermann/pen/LExXWW
        public static let gradientColors = [
            #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), #colorLiteral(red: 0.2039215686, green: 0.6666666667, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),
        ]
    }
}

public extension CGFloat {

    // swiftlint:disable:next missing_docs
    enum GradientLoadingBar {
        /// The default height of the `GradientLoadingBar`.
        public static let height: CGFloat = 3
    }
}

public extension TimeInterval {

    // swiftlint:disable:next missing_docs
    enum GradientLoadingBar {
        /// The default duration for fading-in the loading bar, measured in seconds.
        public static let fadeInDuration = 0.33

        /// The default duration for fading-out the loading bar, measured in seconds.
        public static let fadeOutDuration = 0.66

        /// The default duration for the progress animation, measured in seconds.
        public static let progressDuration = 3.33
    }
}
