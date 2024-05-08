//
//  ViewController.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-02.
//

import UIKit
import SnapKit
import Combine

class CalculatorVC: UIViewController {

    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
        
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView() /// added for flex height to remove warning
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
        
    private let vm = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()
        
//MARK: - INIT view
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind() ///bind with ViewModel
    }
    
    private func bind() {
        //test
        /// You can also get the values from billInputView.valuePublisher like this
        /*
        billInputView.valuePublisher.sink { bill in
            print("bill: \(bill)")
        }.store(in: &cancellables)
        */
        
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: Just(5).eraseToAnyPublisher())
        
        let output = vm.transform(input: input)
        output.updateViewPublisher.sink { result in
            print(">>>>> \(result)")
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
                
        // Constraints
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }            
        
        // Height
        logoView.snp.makeConstraints{ make in
            make.height.equalTo(48)
        }
        resultView.snp.makeConstraints{ make in
            make.height.equalTo(224)
        }
        billInputView.snp.makeConstraints{ make in
            make.height.equalTo(56)
        }
        tipInputView.snp.makeConstraints{ make in
            make.height.equalTo(56+56+15)
        }
        splitInputView.snp.makeConstraints{ make in
            make.height.equalTo(56)
        }
    }
}

