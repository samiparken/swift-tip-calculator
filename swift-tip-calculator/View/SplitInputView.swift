//
//  SplitInputView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit

class SplitInputView: UIView {
//MARK: - View Components
    
    private let labelView: TwoLineLabelView = {
        let view = TwoLineLabelView()
        view.configure(
            topText: "Split",
            bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            text: "-",
            corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
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
        backgroundColor = .systemBlue
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
}

