//
//  MakeStoryView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct MakeStoryView: View {
    @State var storyCount: Int = 0
    @State var isEnd: Bool = false
    @StateObject var speechRecognizer = SpeechRecognizer()
    @EnvironmentObject var user: User
    @State var speechModel = SpeechModel()
    @State var soundManager = SoundManager.instance
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Label("띵동! 소리가 나면 이야기를 시작해주세요.", systemImage: "lightbulb.fill")
                    .font(.custom("CookieRunOTF-Regular", size: 24))
                    .foregroundColor(Color("primary"))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 88)
                    .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color("brown900"))
                    )
                    .padding(.bottom, 72)
                
                ScrollView {
                    Text("1장. ")
                        .lineLimit(nil)
                        .allowsTightening(true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 8)
                            .fill(Color("primary"))
                    }
                )
                .padding(.bottom, 32)
                
                NavigationLink(destination: EndStoryView()) {
                    ButtonImage(systemName: "chevron.forward", disabled: false)
                }
                .simultaneousGesture(TapGesture().onEnded{
                    speechModel.speechStop()
                })
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onChange(of: self.storyCount) { count in
            if count > 3 {
                isEnd = true
            }
        }
    }
}
