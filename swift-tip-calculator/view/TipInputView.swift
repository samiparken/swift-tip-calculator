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
}
