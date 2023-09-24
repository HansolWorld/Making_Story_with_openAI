//
//  DefaultView.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct DefaultView: View {
    let firstSentence: String
    let secondSentence: String
    let isShowingSound: Bool
    let isSecondBold: Bool
    var body: some View {
        VStack {
            if isShowingSound {
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
                    .padding(.bottom, 124)
            } else {
            }
            HStack {
                Image(systemName: "waveform")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .padding(.horizontal, 45)
                    .foregroundColor(Color("primary"))
                VStack(alignment: .leading) {
                    Text(firstSentence)
                    Text(secondSentence)
                        .fontWeight(isSecondBold ? .bold : .regular)
                }
                .font(.custom("CookieRunOTF-Regular", size: 36))
            }
            .padding(.top, isShowingSound ? 0 : 184)
            .padding(.bottom, 200)
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView(firstSentence: "안녕! 나는 함께 동화를 만들 '누구'라고 해.", secondSentence: "너의 이름을 알려줄래?", isShowingSound: false, isSecondBold: true)
    }
}
