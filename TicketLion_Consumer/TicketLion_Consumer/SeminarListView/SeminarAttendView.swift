//
//  SeminarAttendView.swift
//  TicketLion_Comsumer
//
//  Created by 윤진영 on 2023/09/06.
//

import SwiftUI

struct SeminarAttendView: View {
    let user: User
    @Binding var isShowingDetail: Bool
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    SeminarInfoView(seminar: Seminar.seminarsDummy[0])
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("신청자 정보")
                            .font(.title3)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        Grid(alignment: .topLeading) {
                            GridRow {
                                Text("이름")
                                    .bold()
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                
                                Text("\(user.name)")
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            
                            GridRow {
                                Text("이메일")
                                    .bold()
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                
                                Text("\(user.email)")
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            
                            GridRow {
                                Text("전화번호")
                                    .bold()
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                
                                Text("\(user.phoneNumber)")
                            }
                        }
                    }.padding()
                    Divider()
                    SeminarAttendPlusView(isShowingDetail: $isShowingDetail)
                }.navigationTitle("신청하기")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SeminarAttendView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAttendView(user: User.usersDummy[0], isShowingDetail: .constant(true))

    }
}
