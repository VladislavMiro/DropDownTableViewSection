//
//  Section.swift
//  TableView
//
//  Created by Vladislav Miroshnichenko on 29.10.2022.
//

import UIKit

@IBDesignable final class Section: UIView {
    
    private let button = UIButton()
    public let label = UILabel()
    private var isHiddenSection = false
    public weak var delegate: TableViewSectionDelegate?
    public var sectionNumber: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        configureLabel()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
        configureLabel()
        configureView()
    }
    
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            button.widthAnchor.constraint(equalToConstant: self.bounds.height),
            
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalToSystemSpacingAfter: button.leadingAnchor, multiplier: 1.0),
            label.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
    }

    private func configureView() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        backgroundColor = .systemBackground
    }
    
}

// MARK: Label configure

extension Section {
    
    private func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.minimumScaleFactor = 0.1
        label.backgroundColor = .clear
        
        addSubview(label)
    }
    
}

// MARK: Button configure

extension Section {
    
    private func configureButton() {
        let image = UIImage(systemName: "control")
        
        button.setBackgroundImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonTarget), for: .touchUpInside)
        addSubview(button)
    }
    
    @objc private func buttonTarget() {
        isHiddenSection = !isHiddenSection
        
        if isHiddenSection {
            delegate?.hideSetion(inSection: sectionNumber)
            buttonAnimation(toValue: CGFloat.pi)
        } else {
            delegate?.showSection(inSection: sectionNumber)
            buttonAnimation(toValue: 2 * CGFloat.pi)
        }
    }
    
    private func buttonAnimation(toValue: CGFloat) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.toValue = toValue
        animation.duration = 0.3
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        button.layer.add(animation, forKey: nil)
    }
    
}
