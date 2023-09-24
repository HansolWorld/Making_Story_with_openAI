//
//  ButtonText.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct ButtonText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.custom("CookieRunOTF-Regular", size: 36).weight(.bold))
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(Color("primary"))
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonText(text: "응, 좋아!")
    }
}
