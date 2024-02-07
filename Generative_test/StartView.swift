//
//  StartView.swift
//  Generative_test
//
//  Created by apple on 2023/08/26.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationLink(destination: NameEnterView()) {
                Text("시작하기")
                    .foregroundColor(.white)
                    .font(.system(size: 20).weight(.bold))
                    .padding(.vertical, 16)
                    .padding(.horizontal, 200)
                    .background(Color("primary"))
                    .cornerRadius(20)
                    .padding(.bottom, 76)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartView()
        }
    }
}
