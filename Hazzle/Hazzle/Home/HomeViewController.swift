//
//  HomeViewController.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/23.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {
    let habits = ["수영하기 🏊‍♀️","물 마시기 💦", "일기 쓰기 📓"]
    let habitCnts = [13,33,53]
    var selectedH = ""
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
     
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }


}

//MARK:- configuration Views
extension HomeViewController{
    func initUI(){
        //스크롤 뷰 생성
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+400)
        let scrollView = UIScrollView().then{
            $0.frame = .zero
            $0.backgroundColor = .white
            $0.frame = self.view.bounds
            $0.contentSize = contentViewSize
            $0.autoresizingMask = .flexibleHeight
            $0.bounces = true
            $0.showsVerticalScrollIndicator = false
        }
        
        let containerView = UIView().then{
            $0.backgroundColor = .white
            $0.frame.size = contentViewSize
        }
        
        let stackView = UIStackView().then{
            $0.alignment = .fill
            $0.axis = .vertical
            $0.spacing = 15
            $0.distribution = .fillEqually
        }
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
 
        stackView.snp.makeConstraints { (this) in
            this.top.equalTo(containerView).offset(15)
            this.leading.equalTo(containerView).offset(15)
            this.trailing.equalTo(containerView).offset(-15)
        }
        
        
        //습관 뷰 추가
        for i in 0..<3{
            
            let habitContainer = UIView().then{
                $0.layer.cornerRadius = 30
                $0.layer.borderWidth = 1
                $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                $0.isUserInteractionEnabled = true
                $0.viewWithTag(i)
            }
            
            let habitInfoStack = UIStackView().then{
                $0.alignment = .fill
                $0.axis = .horizontal
                $0.spacing = 15
                $0.distribution = .fillProportionally
            }
            let habitTitle = UILabel().then{
                $0.text = habits[i]
            }
            let habitCnt = UIButton().then{
                $0.setTitle("\(habitCnts[i])", for: .normal)
                $0.backgroundColor = #colorLiteral(red: 0.2319215834, green: 0.5326585174, blue: 0.9921949506, alpha: 1)
                $0.setTitleColor(.white, for: .normal)
                $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
                $0.frame.size = CGSize(width: 20, height: 20)
                $0.layer.cornerRadius = 0.5 * $0.bounds.size.width
                $0.isUserInteractionEnabled = false
            }
            
            let upButton = UIButton().then{
                $0.setTitle("+", for: .normal)
                $0.setTitleColor(.gray, for: .normal)
                $0.setTitleColor(.blue, for: .focused)
                $0.addTarget(self, action: #selector(self.habitCntAdd(_:)), for: .touchUpInside)
            }
            let downButton = UIButton().then{
                $0.setTitle("-", for: .normal)
                $0.setTitleColor(.gray, for: .normal)
                $0.setTitleColor(.blue, for: .focused)
                $0.addTarget(self, action: #selector(self.habitCntRevert(_:)), for: .touchUpInside)
            }
            
            habitInfoStack.addArrangedSubview(habitTitle)
            habitInfoStack.addArrangedSubview(habitCnt)
             
            habitContainer.addSubview(habitInfoStack)
            habitContainer.addSubview(upButton)
            habitContainer.addSubview(downButton)
            
            habitInfoStack.snp.makeConstraints { (this) in
                this.top.equalTo(habitContainer).offset(15)
                this.bottom.equalTo(habitContainer).offset(-15)
                this.centerX.equalTo(habitContainer)
            }
            
            upButton.snp.makeConstraints { (this) in
                this.top.equalTo(habitContainer).offset(10)
                this.trailing.equalTo(habitContainer).offset(-15)
            }
            downButton.snp.makeConstraints { (this) in
                this.top.equalTo(habitContainer).offset(10)
                this.leading.equalTo(habitContainer).offset(15)
            }
            
            
            let tab = UITapGestureRecognizer(target: self, action: #selector(self.goToDetail(_:)))
            habitContainer.addGestureRecognizer(tab)
            stackView.addArrangedSubview(habitContainer)
             
        }
    }
}
     

//MARK:- methos
extension HomeViewController{
    
    //habit swipe
//    @objc func swipehabit(_ sender:UIGestureRecognizer){
//        if let swipe = sender as? UISwipeGestureRecognizer {
//            switch swipe.direction{
//                case .left:
//                    print("l")
//                case .right:
//                    print("r")
//                default:
//                    break
//            }
//        }
//    }
    
    //습관 완료 추가
    @objc func habitCntAdd(_ sender:UIButton){
        
    }
    
    //습관 완료 취소
    @objc func habitCntRevert(_ sender:UIButton){
    }
    
    @objc func goToDetail(_ sender:UIGestureRecognizer){
//        guard let tabGesture = sender as? UITapGestureRecognizer else {return}
//        guard let selected = tabGesture.view as? UIView else {return}
//        self.selectedH = "\(selected.tag)"
        //선택된 습관 객체 넘겨주기
        let nextVC:HabitDetailViewController = HabitDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
     
 
}
