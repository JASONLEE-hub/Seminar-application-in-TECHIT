//
//  SeminarListView.swift
//  TicketLion_Comsumer
//
//  Created by 이재승 on 2023/09/06.
//

import SwiftUI

struct SeminarListView: View {
    // ViewModel
    @EnvironmentObject var userStore: UserStore
    @StateObject var seminarStore: SeminarStore = SeminarStore()
    @State private var selectedCategory: Category = .FrontEnd
    @State private var search: String = ""
    @State private var isShowingDetail: Bool = false
    @State private var showingAlert = false
    @State private var newSeminar: Seminar = Seminar.seminarsDummy[1]
    
    var body: some View {
        NavigationStack {
            // CustomCategoryBar
            ScrollView(.horizontal, showsIndicators: false){
                seminarCategoryButton
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 2, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            // SeminarList SubView
            ScrollView {
                SeminarListSubView(seminarStore: seminarStore, category: $selectedCategory, search: $search, showingAlert: $showingAlert)
            }
            // Login Check
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("로그인후 이용해주세요"),
                      message: nil,
                      primaryButton: .default(Text("로그인 하기")) {
                    // LoginSceneに移動
                    userStore.loginSheet = true
                }, secondaryButton: .cancel(Text("취소하기"))
                )
            }
            .navigationTitle("세미나 목록")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // SeminarList, UserData Update
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            .refreshable {
                // SeminarList, UserData Update
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            // Seminar 検索
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt:
                            // categoryがetcの場合、他の場合
                        selectedCategory.categoryName == "etc." ? "그외 세미나를 찾아보세요.": "\(selectedCategory.categoryName) 세미나를 찾아보세요.")
        }
    }
}

extension SeminarListView {
    // CustomCategoryBar
    var seminarCategoryButton: some View {
        HStack {
            ForEach(Category.allCases, id: \.rawValue) { category in
                VStack {
                    // selectedCategory design
                    if selectedCategory == category {
                        Text(category.categoryName)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(20)
                        // 他のCategory design
                    } else {
                        Text(category.categoryName)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1.5))
                    }
                }
                // Animation
                .onTapGesture {
                    withAnimation {
                        self.selectedCategory = category
                        print(self.selectedCategory)
                    }
                }
            }
            .padding(.leading, 2)
            Spacer()
        }
        .padding(.leading)
    }
}

struct SeminarListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SeminarListView()
                .environmentObject(UserStore())
        }
    }
}

