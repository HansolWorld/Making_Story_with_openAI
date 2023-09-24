//
//  StartStoryView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct StartStoryView: View {
    @EnvironmentObject var user: User
    @State var speechModel = SpeechModel()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                DefaultView(firstSentence: "\(user.name ?? "친구")(이)야, 우리 함께", secondSentence: "아주 특별한 동화책을 만들어볼까?", isShowingSound: false, isSecondBold: true)
                Spacer()
                NavigationLink(destination: TitleEnterView()) {
                    ButtonText(text: "응, 좋아!")
                }
                .simultaneousGesture(TapGesture().onEnded{
                    speechModel.speechStop()
                })
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            speechModel.speechText(to: "\(user.name ?? "친구")(이)야, 우리 함께 아주 특별한 동화책을 만들어볼까?")
        }
    }
}

struct StartStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartStoryView()
                .environmentObject(User(name: "Hansol"))
        }
    }
}
