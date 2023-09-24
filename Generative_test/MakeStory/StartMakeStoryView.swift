//
//  StartMakeStoryView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct StartMakeStoryView: View {
    @State var speechModel = SpeechModel()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "waveform")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                        .padding(.horizontal, 45)
                        .foregroundColor(Color("primary"))
                    VStack(alignment: .leading) {
                        Text("좋아!")
                        HStack(spacing: 0) {
                            Text("지금부터 ")
                            Text("너가 하나씩 말한 장면 뒤에")
                                .bold()
                        }
                        HStack(spacing: 0) {
                            Text("내가 이어서 이야기 하며")
                                .bold()
                            Text("같이 놀거야")
                        }
                        Text(" ")
                        Text("동화를 다 쓰고나면 그림도 그리자.")
                        Spacer()
                    }
                    .font(.custom("CookieRunOTF-Regular", size: 36))
                    Spacer()
                }
                .padding(.top, 184)
                Spacer()
                NavigationLink(destination: MakeStoryView()) {
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
            speechModel.speechText(to: "좋아! 지금부터 너가 하나씩 말한 장면 뒤에 내가 이어서 이야기 하며 같이 놀거야, 동화를 다 쓰고나면 그림도 그리자.")
        }
    }
}

struct StartMakeStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartMakeStoryView()
        }
    }
}
