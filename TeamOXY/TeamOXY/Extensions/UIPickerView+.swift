//
//  UIPickerView+.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/16.
//

import SwiftUI

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
    }
}
