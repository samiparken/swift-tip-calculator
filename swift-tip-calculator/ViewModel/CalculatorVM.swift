//
//  CalculatorVM.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-08.
//

import Foundation
import Combine

class CalculatorVM {
    
//MARK: - Input
    struct Input {
        //3 inputs from the view
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
//MARK: - Output
    struct Output {
        // 3 outputs (in Result) to the view
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
//MARK: - Transform
    func transform(input: Input) -> Output {
        
        //test
        /*
        /// you can also check the value from billPublisher (BillInputView)
        input.billPublisher.sink { bill in
            print("the bill: \(bill)")
        }.store(in: &cancellables)
        */
        
        input.tipPublisher.sink { tip in
            print("the tip: \(tip)")
        }.store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.0)
                
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }    
}
