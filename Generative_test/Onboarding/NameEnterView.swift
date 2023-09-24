//
//  NameEnterView.swift
//  Generative_test
//
//  Created by apple on 2023/08/22.
//

import SwiftUI

struct NameEnterView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @EnvironmentObject var user: User
    @State var speechModel = SpeechModel()
    @State var soundManager = SoundManager.instance
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                DefaultView(firstSentence: "안녕! 나는 함께 동화를 만들 '누구'라고 해.", secondSentence: "너의 이름을 알려줄래?", isShowingSound: true, isSecondBold: true)
                HStack {
                    Text("내 이름은 ")
                    VStack(spacing: 1) {
                        Text(user.name ?? " ")
                            .foregroundColor(Color("primary"))
                        Divider()
                            .frame(width: 300, height: 4)
                            .overlay(Color("primary"))
                    }
                    Text("(이)야")
                }
                .font(.custom("CookieRunOTF-Regular", size: 44))
                Spacer()
                HStack(spacing: 24) {
                    Spacer()
                    if speechRecognizer.isTranscript == true {
                        Text("이름을 말한 후, 버튼을 눌러주세요. ->")
                            .font(.system(size: 24).weight(.bold))
                            .foregroundColor(Color("primary"))
                    }
                    Button(action: {
                        speechRecognizer.buttonAction()
                        if speechRecognizer.isTranscript == false {
                            user.name = speechRecognizer.transcript
                            soundManager.playSound(sound: .end)
                        } else {
                            soundManager.playSound(sound: .start)
                        }
                    }) {
                        ButtonImage(systemName: speechRecognizer.isTranscript ? "arrow.counterclockwise" : "mic.fill", disabled: false)
                    }
                    NavigationLink(destination: StartStoryView()) {
                        ButtonImage(systemName: "chevron.forward", disabled: user.name == nil)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        speechModel.speechStop()
                    })
                    .disabled(user.name == nil)
                }
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            speechModel.speechText(to: "안녕! 나는 함께 동화를 만들 '누구'라고 해. 너의 이름을 알려줄래?")
        }
    }
}

struct NameEnterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NameEnterView()
                .environmentObject(User())
        }
    }
}
