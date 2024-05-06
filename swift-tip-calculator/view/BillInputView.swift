//
//  BillInputView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit

class BillInputView: UIView {

    // Constants
    private let billInputLabelView: BillInputLabelView = {
        return BillInputLabelView()
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = LabelFactory.build(
            text: "kr",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        // Add toolbar
        let toolBar = UIToolbar(frame: CGRect(x:0,y:0,width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped))
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    //Init
    init() {
        super.init(frame: .zero)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    private func layout() {
        //addSubview(billInputLabelView)
        //addSubview(textFieldContainerView)
        // it does the same as above
        [billInputLabelView, textFieldContainerView].forEach(addSubview(_:))
                
        billInputLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(68)
            make.height.equalTo(40)
            make.centerY.equalTo(textFieldContainerView.snp.centerY) //align horizontal
            make.trailing.equalTo(textFieldContainerView.snp.leading ).offset(-24) // set order in horizontal
        }
        
        //TextFieldContainer
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        textFieldContainerView.addSubview(currencyLabel)
        textFieldContainerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
        
    @objc private func doneButtonTapped() {
        textField.endEditing(true) //close keyboard
    }
}

class BillInputLabelView: UIView {
    
    // View constants
    private let topLabel: UILabel = {
        LabelFactory.build(
            text: "Enter",
            font: ThemeFont.demibold(ofSize: 20),
            textAlignment: .left)
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "your bill",
            font: ThemeFont.regular(ofSize: 18),
            textAlignment: .left)
    }()
    
    private lazy var vLabelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -2
        return view
    }()

    
    //Init
    init() {
        super.init(frame: .zero)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        addSubview(vLabelStackView)
        
        vLabelStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
}

