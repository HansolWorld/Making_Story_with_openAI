//
//  TitleEnterView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct TitleEnterView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @EnvironmentObject var user: User
    @State var speechModel = SpeechModel()
    @State var soundManager = SoundManager.instance
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                DefaultView(firstSentence: "좋아! 오늘 쓰고 싶은 동화의 주제나,", secondSentence: "주인공이 있니?", isShowingSound: true, isSecondBold: true)
                Text(user.title ?? " ")
                    .padding(.bottom, 1)
                    .font(.custom("CookieRunOTF-Regular", size: 40))
                    .foregroundColor(Color("primary"))
                Divider()
                    .frame(width: 480, height: 4)
                    .overlay(Color("primary"))
                Spacer()
                HStack(spacing: 24) {
                    Spacer()
                    if speechRecognizer.isTranscript == true {
                        Text("주제를 말한 후, 버튼을 눌러주세요. ->")
                            .font(.system(size: 24).weight(.bold))
                            .foregroundColor(Color("primary"))
                    }
                    Button(action: {
                        speechRecognizer.buttonAction()
                        if speechRecognizer.isTranscript == false {
                            user.title = speechRecognizer.transcript
                            soundManager.playSound(sound: .end)
                        } else {
                            soundManager.playSound(sound: .start)
                        }
                    }) {
                        ButtonImage(systemName: speechRecognizer.isTranscript ? "arrow.counterclockwise" : "mic.fill", disabled: false)
                    }
                    NavigationLink(destination: StartMakeStoryView()) {
                        ButtonImage(systemName: "chevron.forward", disabled: user.title == nil)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        speechModel.speechStop()
                    })
                    .disabled(user.title == nil)
                }
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            speechModel.speechText(to: "좋아! 오늘 쓰고 싶은 동화의 주제나 주인공이 있니?")
        }
    }
}

struct TitleEnterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TitleEnterView()
                .environmentObject(User(name: "한솔"))
        }
    }
}
