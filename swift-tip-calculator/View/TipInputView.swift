//
//  TipInputView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit
import Combine
import CombineCocoa

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
        
        //publish
        ///Transform this tab event into another publisher/subject (tipSubject)
        ///Set Tip.tenPercent on tipSubject via \.value property
        button.tapPublisher.flatMap ({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
          .store(in: &cancellables)
        
        return button
    }()
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
          .store(in: &cancellables)
        return button
    }()
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
          .store(in: &cancellables)
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

    // custom tip button at the bottom
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addRoundedCorners(radius: 8.0)
        
        ///bind to member function
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
        
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

//MARK: - CurrentValueSubject
    
    /// CurrentValueSubject can have a default value while PassthorughSubject can't.
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none) /// value to emit
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()

    
//MARK: - INIT View
    init() {
        super.init(frame: .zero)
        layout()
        
        ///print initial value of tipSubject
        //print("tip: \(tipSubject.value)")
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
            make.centerY.equalTo(buttonsHStackView.snp.centerY) ///align horizontal
            make.trailing.equalTo(allButtonsVStackView.snp.leading ).offset(-24) /// set order in horizontal
        }
        
        // allButtonsVStackView
        allButtonsVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white ///it's overwritten by the attributes below
        button.addRoundedCorners(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white  ///this will apply white color on the attributed text
            ])
        //percent
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
//MARK: - METHOD
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okAction = UIAlertAction(
                title: "OK",
                style: .default) { [weak self] _ in
                    guard let text = controller.textFields?.first?.text, let value = Int(text) else { return }
                    self?.tipSubject.send(.custom(value: value))
                }
            [okAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        
        
        
    }
            
}
