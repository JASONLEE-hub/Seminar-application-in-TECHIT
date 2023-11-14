//
//  SeminarData.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct Seminar: Identifiable, Codable, Hashable {

    var id: String = UUID().uuidString
    /// Seminar Category
    var category: [String]
    /// Seminar Title
    var name: String
    /// Seminar Image
    var seminarImage: String
    /// Seminar Host Name
    var host: String
    /// Seminar Detail
    var details: String
    /// Place address
    var location: String?
    /// Maximum number of seminar recruits
    var maximumUserNumber: Int
    /// Seminar closing status
    var closingStatus: Bool
    /// Seminar Recruitment Start Date
    var registerStartDate: Double
    /// Seminar Recruitment End Date
    var registerEndDate: Double
    /// Seminar Start Date
    var seminarStartDate: Double
    /// Seminar End Date
    var seminarEndDate: Double
    /// Seminar Participants
    var enterUsers: [String]
    
    static let TempSeminar: Seminar = Seminar(category: ["iOS Dev", "Front-End"], name: "피카추가 알려주는 강해지는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148792629149052968/pikachu.png", host: "피캇추", details: "일타강사 피캇추가 따라하기만 하면 강해지는 iOS앱 강의! 스위프트로 혼내줍니다.", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","지우","웅이"])

    
    static let seminarsDummy: [Seminar] = [
        Seminar(category: ["iOS Dev", "Front-End"], name: "피카추가 알려주는 강해지는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148792629149052968/pikachu.png", host: "피캇추", details: "일타강사 피캇추가 따라하기만 하면 강해지는 iOS앱 강의! 스위프트로 혼내줍니다.", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","지우","웅이"]),
        Seminar(category: ["Android Dev", "Front-End"], name: "들으면 극락가는 Android앱!", seminarImage: "https://mblogthumb-phinf.pstatic.net/MjAxODA4MTVfMjI5/MDAxNTM0MzM1NjYwOTEw.DQHKsUBpla1Ugx-5wbDKiEqTymCOD8hXeZ21PJm0ohsg.5MylK5vYRe7DYijif1xnH6Xic6RDe9D8YTLy641e2o4g.PNG.qbxlvnf11/7b5e56_d42a0c16a2e64a72b0221462c555f818-mv2.png?type=w800", host: "우서코", details: "다같이 천국 갑시다!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","팀쿡"]),
        Seminar(category: ["Android Dev", "Back-End"], name: "자꾸만 듣고 싶은 안드로이드 Back-End!", seminarImage: "https://images.velog.io/images/c-on/post/2b806749-2868-4c76-8c3f-9f1e3fdc3797/hire-backend-developer.jpg", host: "개굴", details: "마약같은 Android 서버강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승", "우서코", "피의종찬"]),
        Seminar(category: ["iOS Dev", "Back-End"], name: "화성으로 떠나는 iOS Back-End!", seminarImage: "https://assets-prd.ignimgs.com/2022/01/28/starcraft-2-wings-of-liberty-button-crop-1643355282078.jpg?width=300&crop=1%3A1%2Csmart&dpr=2", host: "일론 머스크", details: "일론 머스크를 따라하기만 하면 화성에 갈 수 있는 iOS 서버 강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","몸뚱아리","좌무커", "우서코", "피의종찬"]),
    ]
    /// Time Translator
    func timeCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        return formatter.string(from: createdAt)
    }
    
    func startDateCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: createdAt)
    }
    
    func endDateCreator(_ time: Double, _ startDate: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        
        let yearFormatter: DateFormatter = DateFormatter()
        let formatter: DateFormatter = DateFormatter()
        
        
        yearFormatter.dateFormat = "yyyy"
        
        // start年度とend年度が同じならend年度出力しない
        if yearFormatter.string(from: createdAt) == yearFormatter.string(from: Date(timeIntervalSince1970: startDate)) {
            formatter.dateFormat = "MM월 dd일"
        }else {
            formatter.dateFormat = "yyyy월 MM월 dd일"
        }
        
        return formatter.string(from: createdAt)
    }
    
}
