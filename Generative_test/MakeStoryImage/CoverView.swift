//
//  CoverView.swift
//  Generative_test
//
//  Created by apple on 2023/08/31.
//

import SwiftUI

struct CoverView: View {
    @EnvironmentObject var user: User
    @State var canvas: CanvasView = CanvasView()
    
    var body: some View {
        ZStack {
            Color("background")
            VStack {
                ZStack {
                    canvas
                        .padding(.bottom, 32)
                    VStack(alignment: .center) {
                        Text(user.title ?? "")
                            .font(.custom("CookieRunOTF-Regular", size: 64).weight(.bold))
                            .padding(.bottom, 160)
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("작가: \(user.name ?? "")")
                                Text(Date.now, style: .date)
                            }
                            .font(.custom("CookieRunOTF-Regular", size: 32))
                        }
                        .padding(.trailing, 96)
                        Spacer()
                    }
                    .padding(.vertical, 200)
                }
                NavigationLink(destination: StoryView(storyCount: -1)) {
                    ButtonText(text: "완성했어")
                }
                .simultaneousGesture(TapGesture().onEnded{
                    user.coverImage = canvas.saveImage()
                })
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoverView()
                .environmentObject(User(name: "한솔", title: "누구의동화", chapters: [
                    Chapter(story: "옛날 옛날에", image: Image("")),
                    Chapter(story: "아주 먼 옛날에", image: Image("")),
                    Chapter(story: "멀고 먼 옛날에", image: Image("")),
                    Chapter(story: "끝", image: Image(""))]))
        }
    }
}
