//
//  TwoLineLabelView.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-06.
//

import UIKit

class TwoLineLabelView: UIView {
    
    // View constants
    private let topLabel: UILabel = {
        LabelFactory.build(
            text: "Enter",
            font: ThemeFont.demibold(ofSize: 18),
            textAlignment: .left)
    }()
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "your bill",
            font: ThemeFont.regular(ofSize: 16),
            textAlignment: .left)
    }()
    
    // top and bottom padding for auto layout
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var vLabelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = -4
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
            make.edges.equalToSuperview()  // for top, leading, bottom, trailing edges
            //make.top.bottom.equalToSuperview() // only for top and bottom
        }
        //Set the same padding size on the top and the bottom
        topSpacerView.snp.makeConstraints{ make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
