//
//  SeminarListSubView.swift
//  TicketLion_Consumer
//
//  Created by 이재승 on 2023/09/13.
//

import SwiftUI

struct SeminarListSubView: View {
    // ViewModel
    @ObservedObject var seminarStore: SeminarStore
    @EnvironmentObject var userStore: UserStore
    // SeminarListVIewからBinding
    @Binding var category: Category
    @Binding var search: String
    @Binding var showingAlert: Bool
    // State
    @State var isShowingDetail: Bool = false
    @State var newSeminar: Seminar = Seminar.seminarsDummy[1]
    
    var body: some View {
        // 登録開始順に並べ替え。 検索したセミナーだけが見えるように実装。
        ForEach(seminarStore.seminarList.sorted(by: {$0.registerStartDate < $1.registerStartDate}).filter({"\($0)".localizedStandardContains(self.search) || self.search.isEmpty})) { seminar in
            // 推してるcategoryのセミナーだけが見えるように実装。
            if seminar.category.contains(category.categoryName) {
                // DetailViewに移動するButton
                Button {
                    // DetailViewにseminarDataをBindingで転送するために。
                    newSeminar = seminar
                    // DetailViewに移動
                    isShowingDetail = true
                } label: {
                    // SeminarList Design
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(seminar.name)")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            
                            Spacer()
                            
                            Text("\(seminar.enterUsers.count)/\(seminar.maximumUserNumber)")
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                .background(Color("AnyButtonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(3)
                            
                            
                            Text(seminar.closingStatus ? "모집마감" : "모집중")
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                .background(seminar.closingStatus ? .red : .blue)
                                .border(seminar.closingStatus ? .red : .blue)
                                .foregroundColor(.white)
                                .cornerRadius(3)
                            
                            Button { // Favorite button
                                // User, favoriteSeminarにセーブ
                                // セーブ後、UserのfavoriteSeminar Arrayに該当Seminarがあれば星マークにライトが点かなければならない
                                
                                //　Optional Check
                                if let _ = userStore.currentUser {
                                    if userStore.favoriteSeminars.firstIndex(of: "\(seminar.id)") != nil {
                                        // Favorite 削除
                                        userStore.removeFavoriteSeminar(seminarID: seminar.id)
                                        print("\(userStore.favoriteSeminars)")
                                        
                                    } else {
                                        // Favorite 入り
                                        userStore.addFavoriteSeminar(seminarID: seminar.id)
                                        print("\(userStore.favoriteSeminars)")
                                    }
                                } else {
                                    // userStore.currentUserがなかったら、会員登録誘導Alert
                                    showingAlert = true
                                }
                            } label: {
                                Image(systemName: 
                                        // favoriteSeminarsにseminar.idがあるかないかによってのDesign
                                      userStore.favoriteSeminars.contains(seminar.id) ? "star.fill" : "star")
                                    .foregroundColor(userStore.favoriteSeminars.contains(seminar.id) ? Color("AnyButtonColor") : .gray)
                            }
                        }
                        .bold()
                        .font(.callout)
                        
                        // Seminar Image Design
                        VStack {
                            HStack(alignment: .top) {
                                AsyncImage(url: URL(string: seminar.seminarImage)) { phase in
                                    if let image = phase.image {
                                        image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fill)
                                    } else if phase.error != nil { 
                                        // errorの時
                                        Image("TicketLion")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .aspectRatio(contentMode: .fill)
                                    } else { 
                                        // placeholder
                                        Image("TicketLion")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .aspectRatio(contentMode: .fill)
                                    }
                                }
                                
                                // Seminar Detail
                                VStack(alignment: .leading) {
                                    Group {
                                        Text("강연자 : \(seminar.host)")
                                        Text("장소 : \(seminar.location ?? "location -")")
                                        Text("날짜 : \(seminar.startDateCreator(seminar.registerStartDate)) 부터")
                                        Text("시간 : \(seminar.timeCreator( seminar.registerStartDate)) ~ \(seminar.timeCreator( seminar.registerEndDate))")
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                }
                                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                            }
                        }
                    }
                    .padding()
                    .background(Color("Color"))
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                    
                } // DetailViewに移動するButton終わり
            }
        }
        // isShowingDetailの変化があったらfetch
        .onChange(of: isShowingDetail, perform: { newValue in
            seminarStore.fetchSeminar()
        })
        .fullScreenCover(isPresented: $isShowingDetail) {
            NavigationStack {
                // DetailViewに移動
                SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $newSeminar)
            }
        }
    }
}

struct SeminarListSubView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarListSubView(seminarStore: SeminarStore(), category: .constant(.iOSDevelop), search: .constant(""), showingAlert: .constant(false))
    }
}
