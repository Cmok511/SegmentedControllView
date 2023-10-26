//
//  SegmentedControllView.swift
//  SegmentedView
//
//  Created by Денис Чупров on 27.10.2023.
//

import Foundation
import UIKit


import Foundation
import UIKit

protocol SegmentedControlViewDataSourse: AnyObject {
    func segmentedlCount(_ segmentedControllView: SegmentedControlView) -> Int
    func segmentedTitle(_ segmentedControllView: SegmentedControlView, indexPath: IndexPath) -> String
}

protocol SegmentedControlViewDelegate: AnyObject {
    func selectedIndex(_ segmentedControllView: SegmentedControlView, index: IndexPath)
}

protocol SegmentedControlVieProtocol {
    var bottomIndicatorHeight: CGFloat { get set }
    var delayOfIndicatorAnimage: Double { get set }
    var colorOfIndicatorView: UIColor { get set }
    var buttonsTitleColor: UIColor { get set }
}

public class SegmentedControlView: UIControl, SegmentedControlVieProtocol {
   
     weak var dataSourse: SegmentedControlViewDataSourse? {
        didSet {
            setupView()
        }
    }
    weak var delegate: SegmentedControlViewDelegate?
    
    public var bottomIndicatorHeight: CGFloat = 2
    public var delayOfIndicatorAnimage: Double = 0.2
    public var colorOfIndicatorView: UIColor = .blue
    public var buttonsTitleColor: UIColor = .lightGray
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var bottomView: UIView = {
        var bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    private var elementsCount: Int = 0
    private var leadingConstraint: NSLayoutConstraint!
    private var bottomViewOffset: CGFloat = 0
    private var buttons: [UIButton] = []
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(stackView)
        stackView.frame = bounds
    }
 
    
    
    private func setupView() {
        bottomView.backgroundColor = colorOfIndicatorView
        elementsCount = dataSourse?.segmentedlCount(self) ?? 0
        for item in 0..<elementsCount {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSourse?.segmentedTitle(self, indexPath: indexPath)
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = item
            button.setTitleColor(self.buttonsTitleColor, for: .normal)
            button.addTarget(self, action: #selector(selectedButton(_:)), for: .touchUpInside )
            buttons.append(button)
            self.addSubview(button)
        }
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(bottomView)
        bottomViewOffset = self.bounds.width / CGFloat(elementsCount) * 0.3 / 2
        leadingConstraint = bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bottomViewOffset)
        leadingConstraint.isActive = true
        let width = self.bounds.width / CGFloat(elementsCount) * 0.7
        NSLayoutConstraint.activate([
            bottomView.widthAnchor.constraint(equalToConstant: width),
            bottomView.heightAnchor.constraint(equalToConstant: bottomIndicatorHeight),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    @objc private func selectedButton(_ sender: UIButton) {
        delegate?.selectedIndex(self, index: IndexPath(row: sender.tag, section: 0))
        let newConstrainntConstant = (self.bounds.width / CGFloat(self.elementsCount)) * CGFloat(sender.tag)
        UIView.animate(withDuration: delayOfIndicatorAnimage) {
            self.leadingConstraint.constant = newConstrainntConstant + self.bottomViewOffset
            self.layoutIfNeeded()
        }
    }
}
