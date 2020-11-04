//
//  HabitDetailViewController.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/23.
//

import UIKit
import SnapKit
import Then
import PuzzleMaker

class HabitDetailViewController: UIViewController {
    // MARK: - Properties
    let screenBounds = UIScreen.main.bounds
    let sideMargin: CGFloat = 30
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 80)
    // MARK: - Views
    lazy var scrollView = UIScrollView().then {
        $0.contentSize = contentViewSize
        $0.frame = self.view.bounds
        $0.autoresizingMask = .flexibleHeight
        $0.showsHorizontalScrollIndicator = true
        $0.bounces = true
    }
    lazy var containerView = UIView().then {
        $0.backgroundColor = . white
        $0.frame.size = contentViewSize
    }
    var puzzleView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.masksToBounds = true // 라운드 크기를 넘어가면 짜르기
        $0.layer.borderColor = UIColor.white.cgColor
    }
    var memoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 5
    }
    var memoAttributeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    var statisticStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    var weekStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
        //        $0.translatesAutoresizingMaskIntoConstraints = false // 이게 없으면 안나옴 뭔지 체크
    }
    var monthStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    var yearStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    var allStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    var continuityStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 60
    }
    var bestStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    var currentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    var puzzleLabel = UILabel().then {
        $0.text = "Puzzle"
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        $0.textAlignment = .left
    }
    var memoLabel = UILabel().then {
        $0.text = "Memo"
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        $0.textAlignment = .left
    }
    var memoListButton = UIButton().then {
        $0.setTitle("MemoList", for: .normal)
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.blue.cgColor // 색상 변경
        $0.backgroundColor = .blue
    }
    var dateLabel = UILabel().then {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        $0.text = dateFormatter.string(from: today)
        $0.font = UIFont(name: "Helvetica", size: 15)
        $0.textAlignment = .left
    }
    lazy var memoTextView = UITextView().then {
        $0.text = "메모를 입력해주세요"
        $0.textColor = UIColor.lightGray
        $0.textAlignment = .left
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.delegate = self
    }
    var statisticLabel = UILabel().then {
        $0.text = "Statistic"
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        $0.textAlignment = .left
    }
    var weekLabel = UILabel().then {
        $0.text = "이번주"
        $0.font = UIFont(name: "Helvetica", size: 10)
        $0.textAlignment = .center
    }
    var monthLabel = UILabel().then {
        $0.text = "이번달"
        $0.font = UIFont(name: "Helvetica", size: 10)
        $0.textAlignment = .center
    }
    var yearLabel = UILabel().then {
        $0.text = "올해"
        $0.font = UIFont(name: "Helvetica", size: 10)
        $0.textAlignment = .center
    }
    var allLabel = UILabel().then {
        $0.text = "전체"
        $0.font = UIFont(name: "Helvetica", size: 10)
        $0.textAlignment = .center
    }
    var weekCountLabel = UILabel().then {
        $0.text = "3"
        $0.font = UIFont(name: "Helvetica", size: UIFont.labelFontSize)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    var monthCountLabel = UILabel().then {
        $0.text = "10"
        $0.font = UIFont(name: "Helvetica", size: UIFont.labelFontSize)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    var yearCountLabel = UILabel().then {
        $0.text = "10"
        $0.font = UIFont(name: "Helvetica", size: UIFont.labelFontSize)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    var allCountLabel = UILabel().then {
        $0.text = "10"
        $0.font = UIFont(name: "Helvetica", size: UIFont.labelFontSize)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    var continuityLabel = UILabel().then {
        $0.text = "Countinuity"
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        $0.textAlignment = .left
    }
    var bestContinuityLabel = UILabel().then {
        $0.text = "Best"
        $0.font = UIFont(name: "Helvetica", size: 15)
        $0.textAlignment = .center
    }
    var currentContinuityLabel = UILabel().then {
        $0.text = "Current"
        $0.font = UIFont(name: "Helvetica", size: 15)
        $0.textAlignment = .center
    }
    var bestCountLabel = UILabel().then {
        $0.text = "6"
        $0.font = UIFont(name: "Helvetica", size: 40)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    var currentCountLabel = UILabel().then {
        $0.text = "3"
        $0.font = UIFont(name: "Helvetica", size: 40)
        $0.textAlignment = .center
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    // MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configurePuzzleView()
        configureMemo()
        configureStatistic()
        configureContinuity()
    }
    func configureScrollView() {
        // Add to view hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    func configurePuzzleView() {
        // Add to view hierarchy
        containerView.addSubview(puzzleLabel)
        containerView.addSubview(puzzleView)
        // Constraints
        puzzleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(10)
            make.leading.equalToSuperview().offset(sideMargin)
            make.trailing.equalToSuperview().offset(-sideMargin)
        }
        puzzleView.snp.makeConstraints { (make) in
            make.top.equalTo(puzzleLabel.snp.bottom).offset(10)
            make.width.height.equalTo(puzzleLabel.snp.width)
            make.centerX.equalTo(self.view)
        }
        // image example handling
        let numRows = 5
        let numColumns = 5
        let imageBool = [[true, true, true, true, true],
                         [true, true, true, true, true],
                         [true, true, true, true, true],
                         [true, true, true, true, true],
                         [true, true, true, true, true]]
        let image = UIImage(named: "testImage")
        let puzzleMaker = PuzzleMaker(image: (image?.resizedImage(for: CGSize(width: self.screenBounds.size.width - 60, height: self.screenBounds.size.width - 60)))!, numRows: numRows, numColumns: numColumns)
        puzzleMaker.generatePuzzles { throwableClosure in
            do {
                let puzzleElements = try throwableClosure()
                for row in 0 ..< numRows {
                    for column in 0 ..< numColumns where imageBool[row][column] {
                        guard let puzzleElement = puzzleElements[row][column] else { continue }
                        let position = puzzleElement.position
                        let image = puzzleElement.image
                        let imgView = UIImageView(frame: CGRect(x: position.x, y: position.y, width: image.size.width, height: image.size.height))
                        imgView.image = image
                        self.puzzleView.addSubview(imgView)
                    }
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    func configureMemo() {
        // Add to view hierarchy
        containerView.addSubview(memoLabel)
        containerView.addSubview(memoStackView)
        memoAttributeStackView.addArrangedSubview(dateLabel)
        //memoAttributeStackView.addArrangedSubview(memoListButton)
        memoStackView.addArrangedSubview(memoAttributeStackView)
        memoStackView.addArrangedSubview(memoTextView)
        // Constraints
        memoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(puzzleLabel)
            make.top.equalTo(puzzleView.snp.bottom).offset(10)
        }
        memoTextView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        memoStackView.backgroundColor = .blue
        memoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(puzzleView)
            make.top.equalTo(memoLabel.snp.bottom).offset(10)
        }
    }
    func configureStatistic() {
        // Add to view hierarchy
        containerView.addSubview(statisticLabel)
        containerView.addSubview(statisticStackView)
        weekStackView.addArrangedSubview(weekLabel)
        weekStackView.addArrangedSubview(weekCountLabel)
        monthStackView.addArrangedSubview(monthLabel)
        monthStackView.addArrangedSubview(monthCountLabel)
        yearStackView.addArrangedSubview(yearLabel)
        yearStackView.addArrangedSubview(yearCountLabel)
        allStackView.addArrangedSubview(allLabel)
        allStackView.addArrangedSubview(allCountLabel)
        statisticStackView.addArrangedSubview(weekStackView)
        statisticStackView.addArrangedSubview(monthStackView)
        statisticStackView.addArrangedSubview(yearStackView)
        statisticStackView.addArrangedSubview(allStackView)
        // Constraints
        statisticLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(memoLabel)
            make.top.equalTo(memoStackView.snp.bottom).offset(10)
        }
        let labels = [weekCountLabel, monthCountLabel, yearCountLabel, allCountLabel]
        for label in labels {
            label.snp.makeConstraints { make in
                make.height.equalTo((self.screenBounds.size.width - sideMargin - sideMargin - 60)/10)
            }
        }
        statisticStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(memoStackView)
            make.top.equalTo(statisticLabel.snp.bottom).offset(10)
        }
    }
    func configureContinuity() {
        // Add to view hierarchy
        containerView.addSubview(continuityLabel)
        containerView.addSubview(continuityStackView)
        currentStackView.addArrangedSubview(currentContinuityLabel)
        currentStackView.addArrangedSubview(currentCountLabel)
        bestStackView.addArrangedSubview(bestContinuityLabel)
        bestStackView.addArrangedSubview(bestCountLabel)
        continuityStackView.addArrangedSubview(currentStackView)
        continuityStackView.addArrangedSubview(bestStackView)
        // Constraints
        continuityLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(statisticLabel)
            make.top.equalTo(statisticStackView.snp.bottom).offset(10)
        }
        continuityStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(statisticStackView)
            make.top.equalTo(continuityLabel.snp.bottom).offset(10)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension HabitDetailViewController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모를 입력해 주세요"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension UIImage {
    // UIGraphicsImageRenderer - Image resize
    func resizedImage(for size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
