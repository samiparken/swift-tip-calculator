//
//  BillInputView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {

//MARK: - View Components
    private let billInputLabelView: TwoLineLabelView = {
        let view = TwoLineLabelView()
        view.configure(
            topText: "Enter",
            bottomText: "your bill")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addRoundedCorners(radius: 8.0)
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

//MARK: - PassthroughSubject & AnyPublisher
    /// PassthroughSubject makes it Observable by other classes
    /// PassthroughSubject can accept & emit values
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    
    /// it publishes billSubject to other class
    /// AnyPublisher can only emit values (read only)
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
            
    // for study
    /// this structure looks like the relationship between PassthroughSubject and AnyPublisher
    private var privateText: String? // it's like PassthroughSubject
    var publicText: String? { //it's like AnyPublisher
        return privateText
    }
    
    private var cancellables = Set<AnyCancellable>()
    
//MARK: - INIT view
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        
        // triggered when text in textField changes
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
            //print("Text: \(text)") //for study
            //privateText = text     //for study
        }.store(in: &cancellables)
    }
        
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
