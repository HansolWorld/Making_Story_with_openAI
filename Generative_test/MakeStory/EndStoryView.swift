//
//  EndStoryView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct EndStoryView: View {
    let speechModel = SpeechModel()
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                DefaultView(firstSentence: "그럼 이제 동화에 들어갈 그림을", secondSentence: "함께 그려볼까?", isShowingSound: false, isSecondBold: true)
                Spacer()
                NavigationLink(destination: MakeStoryCanvasView(storyCount: 0)) {
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
            speechModel.speechText(to: "그럼 이제 동화에 들어갈 그림을 함께 그려볼까?")
        }
    }
}

struct EndStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EndStoryView()
        }
    }
}
