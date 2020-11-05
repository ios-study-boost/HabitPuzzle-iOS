//
//  HabitCreateViewController.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/23.
//

import UIKit

class HabitCreateViewController: UIViewController {
    
    // MARK: - Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    // MARK: - Views
    lazy var containerView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.frame.size = contentViewSize
    }
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .systemGray6
        $0.frame = .zero
        $0.frame = self.view.bounds
        $0.contentSize = contentViewSize
        $0.autoresizingMask = .flexibleHeight
        $0.showsHorizontalScrollIndicator = true
        $0.bounces = true
    }
    
    let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    lazy var puzzleImageButtonStack = UIStackView(arrangedSubviews: [puzzleImageView, puzzleAddButton]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    let puzzleImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .brown
        $0.layer.cornerRadius = 16
    }
    
    let puzzleAddButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("사진 추가", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    lazy var habitInputStack = UIStackView(arrangedSubviews: [habitLabel, habitTextField]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    let habitLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "습관"
    }
    
    let habitTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.placeholder = "습관을 적어주세요."
        $0.returnKeyType = .done
    }
    
    lazy var goalInputView = UIStackView(arrangedSubviews: [goalLabel, goalTextField]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    let goalLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "목표횟수"
    }

    let goalTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.placeholder = "목표횟수를 적어주세요."
        $0.keyboardType = .numberPad
    }
    
    lazy var numberOfDaysInputView = UIStackView(arrangedSubviews: [numberOfDaysLabel, numberOfDaysTextField]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    let numberOfDaysLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "일주일 횟수"
    }
    
    let numberOfDaysTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.placeholder = "일주일에 몇 번 하실 건가요?"
        $0.keyboardType = .numberPad
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation controller bar item
        setRightBarButton()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        addSubviews()
        setConstraint()
    }
    
    private func setRightBarButton() {
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: self,
                                            action: #selector(saveHabit))
        self.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    @objc private func saveHabit() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(puzzleImageButtonStack)
        stackView.addArrangedSubview(habitInputStack)
        stackView.addArrangedSubview(goalInputView)
        stackView.addArrangedSubview(numberOfDaysInputView)
    }
    
    private func setConstraint() {
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(16)
        }
        
        puzzleImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(self.puzzleImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
    }
}
