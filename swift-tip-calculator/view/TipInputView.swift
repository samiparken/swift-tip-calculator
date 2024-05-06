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
    
    // hStackView for tip buttons
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        return button
    }()
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    private lazy var buttonsHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton
            ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    // vertical StackView for all buttons
    private lazy var allButtonsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonsHStackView,
            customTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
        
    
//MARK: - INIT View
    init() {
        super.init(frame: .zero)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        [labelView, allButtonsVStackView].forEach(addSubview(_:))
                
        // Label
        labelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(68)
            make.height.equalTo(40)
            make.centerY.equalTo(buttonsHStackView.snp.centerY) //align horizontal
            make.trailing.equalTo(allButtonsVStackView.snp.leading ).offset(-24) // set order in horizontal
        }
        
        // allButtonsVStackView
        allButtonsVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }

        

    }
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white 
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20)
            ])
        //percent
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}

//MARK: - enum Tip
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
