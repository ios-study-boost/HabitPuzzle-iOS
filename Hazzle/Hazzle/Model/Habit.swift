//
//  Habit.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/20.
//

import Foundation
import RealmSwift

/**
 Habit is a class for save data Realm model objects.
 
 - `identifier`: 식별자
 - `name`: 이름
 - `date`: 생성일
 - `photo`: 퍼즐 이미지
 - `goal`: 목표 횟수
 - `numberOfDays`: 일주일 주기
 - `count`: 완료 횟수
 - `grid`: 완료한 퍼즐을 저장할 `Boolean` 타입의 2차원 배열
 - `memo`: 메모
 */
class Habit: Object {
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var photo: String = ""
    @objc dynamic var goal: Int = 0
    @objc dynamic var numberOfDays: Int = 0
    @objc dynamic var count: Int = 0
    var grid: List<Bool> = List<Bool>()
    var memo: List<Memo> = List<Memo>()
}
