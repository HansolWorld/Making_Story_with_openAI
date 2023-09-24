//
//  StoryView.swift
//  Generative_test
//
//  Created by apple on 2023/08/31.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var user: User
    @EnvironmentObject var appState: AppState
    
    var storyCount: Int
    @State var speechModel = SpeechModel()
    var body: some View {
        ZStack {
            Color("background")
            VStack(alignment: .leading) {
                if storyCount == -1 {
                    ZStack {
                        user.coverImage
                            .background(.white)
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
                } else {
                    user.chapters[storyCount].image
                        .frame(height: UIScreen.main.bounds.height/2)
                        .padding(.bottom, 36)
                        .background(.white)
                    Text(user.chapters[storyCount].story)
                        .font(.custom("CookieRunOTF-Regular", size: 36).weight(.bold))
                    if storyCount == user.chapters.count-1 {
                        Text("-끝-")
                            .font(.custom("CookieRunOTF-Regular", size: 24))
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        speechModel.speechStop()
                        dismiss()
                    }) {
                        ButtonImage(systemName: "chevron.left", disabled: storyCount == 0)
                    }
                    .disabled(storyCount == 0)
                    Spacer()
                    
                    Button(action: {
                        if storyCount == -1 {
                            if let title = user.title {
                                speechModel.speechText(to: title)
                            }
                        } else {
                            speechModel.speechText(to: user.chapters[storyCount].story)
                        }
                    }) {
                        ButtonImage(systemName: "play.fill", disabled: false)
                    }
                    
                    Spacer()
                    
                    if storyCount != user.chapters.count-1 {
                        NavigationLink(destination: StoryView(storyCount: storyCount + 1)) {
                            ButtonImage(systemName: "chevron.right", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            speechModel.speechStop()
                        })
                    } else {
                        Button(action: {
                            speechModel.speechStop()
                            appState.startViewId = UUID()
                        }) {
                            ButtonText(text: "처음으로")
                        }
                        .onDisappear {
                            user.reset()
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StoryView(storyCount: 0)
        }
        .environmentObject(User(name: "한솔", title: "누구의동화", chapters: [
            Chapter(story: "옛날 옛날에", image: Image("")),
            Chapter(story: "아주 먼 옛날에", image: Image("")),
            Chapter(story: "멀고 먼 옛날에", image: Image("")),
            Chapter(story: "끝", image: Image(""))]))
    }
}


