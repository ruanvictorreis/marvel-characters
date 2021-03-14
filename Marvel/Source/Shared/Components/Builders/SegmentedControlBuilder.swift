//
//  SegmentedControlBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 14/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class SegmentedControlBuilder {
    
    // MARK: - Private Properties
    
    private var titles: [String] = []
    
    private var cornerRadius: CGFloat = 20.0
    
    private var accessibilityIdentifier = "segmentedControl"
    
    private var indicatorColor: UIColor = .darkness
    
    private var backgroundColor: UIColor = .clear
    
    private var normalTextColor: UIColor = .darkGray
    
    private var selectedTextColor: UIColor = .white
    
    private var normalFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
    
    private var selectedFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
    
    private var segmentedControl = BetterSegmentedControl()
    
    // MARK: - Public Functions
    
    func set(titles: [String]) -> Self {
        self.titles = titles
        return self
    }
    
    func set(_ target: Any?, action: Selector) -> Self {
        segmentedControl.addTarget(target, action: action, for: .valueChanged)
        return self
    }
    
    func set(width: Double, height: Double) -> Self {
        segmentedControl.frame = CGRect(x: 0, y: 0, width: width, height: height)
        return self
    }
    
    func set(cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        return self
    }
    
    func set(normalTextColor: UIColor) -> Self {
        self.normalTextColor = normalTextColor
        return self
    }
    
    func set(selectedTextColor: UIColor) -> Self {
        self.selectedTextColor = selectedTextColor
        return self
    }
    
    func set(normalFont: UIFont) -> Self {
        self.normalFont = normalFont
        return self
    }
    
    func set(selectedFont: UIFont) -> Self {
        self.selectedFont = selectedFont
        return self
    }
    
    func set(backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func set(indicatorColor: UIColor) -> Self {
        self.indicatorColor = indicatorColor
        return self
    }
    
    func set(accessibilityIdentifier: String) -> Self {
        self.accessibilityIdentifier = accessibilityIdentifier
        return self
    }
    
    func build() -> BetterSegmentedControl {
        let segments = LabelSegment.segments(
            withTitles: titles,
            normalFont: normalFont,
            normalTextColor: normalTextColor,
            selectedFont: selectedFont,
            selectedTextColor: selectedTextColor)
        
        let options: [BetterSegmentedControlOption] = [
            .backgroundColor(backgroundColor),
            .indicatorViewBackgroundColor(indicatorColor),
            .cornerRadius(cornerRadius)]
        
        segmentedControl.options = options
        segmentedControl.segments = segments
        segmentedControl.accessibilityIdentifier = accessibilityIdentifier
        
        return segmentedControl
    }
}
