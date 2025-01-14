//
//  UserData.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import Foundation

struct User: Identifiable, Codable {
    
    /// UUID
    var id: String = UUID().uuidString
    /// User name
    let name: String
    /// User phoneNumber
    let phoneNumber: String
    /// User email
    let email: String
    /// User password
    let password: String
    /// User birthday
    let birth: String
    /// 申請したセミナー
    var appliedSeminars: [String]
    /// お気に入りのセミナー
    var favoriteSeminars: [String]
    /// 最近見たセミナー
    var recentlySeminars: [String]
    /// キャンセルしたセミナー
    var canceledSeminars: [String]
    
    static let usersDummy: [User] = [
        User(name: "생동재희", phoneNumber: "123123", email: "sadasdas@naver.com", password: "1234", birth: "어제", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
        User(name: "몸뚱아리", phoneNumber: "534534", email: "qweqweee@gmail.com", password: "1357", birth: "오늘", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
        User(name: "우서코", phoneNumber: "635635", email: "ljkahsdj@kakao.com", password: "2468", birth: "내일", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
        User(name: "좌강묵", phoneNumber: "345213", email: "adjfhadk@gmail.com", password: "6789", birth: "모레", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
        User(name: "이의재승", phoneNumber: "345213", email: "adjfhadk@naver.com", password: "6789", birth: "모레", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
    ]
}
