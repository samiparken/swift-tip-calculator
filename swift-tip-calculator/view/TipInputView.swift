//
//  TipInputView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit

class TipInputView: UIView {
    
//MARK: - View Components
    
    // Label view
    private let labelView: TwoLineLabelView = {
        let view = TwoLineLabelView()
        view.configure(
            topText: "Choose",
            bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        
    }()
       
//MARK: - Init View
    init() {
        super.init(frame: .zero)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        backgroundColor = .systemPink
    }
    private func buildTipButton() {
        
    }
}

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(value: let value):
            return String(value)
        }
    }
}
