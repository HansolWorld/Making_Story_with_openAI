//
//  MakeCoverView.swift
//  Generative_test
//
//  Created by apple on 2023/08/28.
//

import SwiftUI

struct MakeCoverView: View {
    @State var speechModel = SpeechModel()
    var body: some View {
        ZStack {
            Color("background")
            VStack {
                DefaultView(firstSentence: "잘했어!", secondSentence: "우리 마지막으로 동화 표지를 그려볼까?", isShowingSound: false, isSecondBold: false)
                Spacer()
                NavigationLink(destination: CoverView()) {
                    ButtonText(text: "응, 좋아!")
                }
                .simultaneousGesture(TapGesture().onEnded{
                    speechModel.speechStop()
                })
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            speechModel.speechText(to: "잘했어! 우리 마지막으로 동화 표지를 그려볼까?")
        }
    }
}

struct MakeCoverView_Previews: PreviewProvider {
    static var previews: some View {
        MakeCoverView()
            .environmentObject(User(name: "한솔", title: "누구의동화", coverImage: Image(systemName: "circle"), chapters: [
                Chapter(story: "옛날 옛날에", image: Image("")),
                Chapter(story: "아주 먼 옛날에", image: Image("")),
                Chapter(story: "멀고 먼 옛날에", image: Image("")),
                Chapter(story: "끝", image: Image(""))]))
    }
}
