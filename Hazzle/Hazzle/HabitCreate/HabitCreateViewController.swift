//
//  HabitCreateViewController.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/23.
//

import UIKit
import Photos
import RealmSwift

class HabitCreateViewController: UIViewController {

    // MARK: - Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    var imagePath: String = ""

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
        $0.backgroundColor = .white
        $0.image = UIImage(named: "acorn")
        $0.contentMode = .scaleToFill
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

    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // set navigation title
        self.navigationItem.title = "새로운 습관"

        // set delegate
        picker.delegate = self
        habitTextField.delegate = self
        goalTextField.delegate = self
        numberOfDaysTextField.delegate = self

        // set navigation controller bar item
        setRightBarButton()

        // Set Action to Add Photo Button
        puzzleAddButton.addTarget(self, action: #selector(photoAction), for: .touchUpInside)
        puzzleImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoAction))
        puzzleImageView.addGestureRecognizer(tapGesture)

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
        // get Data from TextField
        let habit = Habit()

        // 공백인 경우 체크
        if !isBlank() { return }

        guard let name = habitTextField.text else {
            return
        }

        guard let goal = goalTextField.text else {
            return
        }

        guard let numberOfDays = numberOfDaysTextField.text else {
            return
        }

        habit.name = name
        habit.goal = Int(goal)!
        habit.numberOfDays = Int(numberOfDays)!
        habit.photo = self.imagePath

        // Get the default Realm
        let realm = try? Realm()
        // You only need to do this once (per thread)

        // Add to the Realm inside a transaction
        try? realm?.write {
            realm?.add(habit)
        }

        self.navigationController?.popViewController(animated: true)
    }

    private func isBlank() -> Bool {
        if !habitTextField.hasText {
            showToast(message: "습관을 입력해주세요.")
            return false
        } else if !goalTextField.hasText {
            showToast(message: "목표횟수를 입력해주세요.")
            return false
        } else if !numberOfDaysTextField.hasText {
            showToast(message: "일주일 횟수를 입력해주세요.")
            return false
        } else if self.imagePath.isEmpty {
            showToast(message: "사진을 추가해주세요.")
            return false
        } else { return true }
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

    @objc private func photoAction() {
        let alert =  UIAlertController(title: "사진 가져오기", message: "어디에서 사진을 가져올까요?", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범", style: .default) { _ in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { _ in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }

    private func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    private func openCamera() {
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
}

extension HabitCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            puzzleImageView.image = image
        }

        if let imagePath = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            self.imagePath = imagePath.absoluteString ?? ""
        }

        dismiss(animated: true, completion: nil)
    }
}

extension HabitCreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitCreateViewController {
    func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: .curveLinear,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: { _ in toastLabel.removeFromSuperview() }
        )
    }
}
