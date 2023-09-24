//
//  ButtonImage.swift
//  Generative_test
//
//  Created by apple on 2023/08/27.
//

import SwiftUI

struct ButtonImage: View {
    let systemName: String
    let disabled: Bool
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 48, height: 48)
            .padding(16)
            .background(disabled ? Color.gray : Color("primary"))
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}

struct ButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        ButtonImage(systemName: "chevron.forward", disabled: true)
    }
}
