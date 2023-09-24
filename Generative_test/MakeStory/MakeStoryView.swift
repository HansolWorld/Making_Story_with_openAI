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
    @StateObject var viewModel = ChatViewModel()
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
                    ScrollViewReader { proxy in
                        VStack(alignment: .leading) {
                            if viewModel.messages.count > 1 {
                                ForEach(1..<viewModel.messages.count, id: \.self) { index in
                                    Text("\(index)장. \( viewModel.messages[index].content)")
                                        .lineLimit(nil)
                                        .allowsTightening(true)
                                        .onAppear {
                                            withAnimation {
                                                proxy.scrollTo(viewModel.messages[index], anchor: .bottom)
                                            }
                                        }
                                }
                            }
                            if viewModel.isLoding {
                                Text("동화를 작성중이야. 조금만 기다려줘")
                            }
                        }
                        .font(.custom("CookieRunOTF-Regular", size: 46))
                        .padding(.vertical, 88)
                        .padding(.horizontal, 56)
                    }
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
                
                if isEnd == false {
                    Button(action: {
                        speechModel.speechStop()
                        speechRecognizer.buttonAction()
                        if speechRecognizer.isTranscript == false {
                            soundManager.playSound(sound: .end)
                            self.storyCount += 2
                            viewModel.currentInput = "\"\(speechRecognizer.transcript)\""
                            viewModel.sendMessage()
                        } else {
                            soundManager.playSound(sound: .start)
                        }
                    }) {
                        ButtonImage(systemName: speechRecognizer.isTranscript ? "arrow.counterclockwise" : "mic.fill", disabled: viewModel.isLoding)
                    }
                    .disabled(viewModel.isLoding)
                } else {
                    NavigationLink(destination: EndStoryView()) {
                        ButtonImage(systemName: "chevron.forward", disabled: viewModel.isLoding)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        speechModel.speechStop()
                    })
                    .disabled(viewModel.isLoding)
                }
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.systemSettingMessage(systemMessage: user.title ?? "")
        }
        .onChange(of: viewModel.messages, perform: { newValue in
            if viewModel.messages.count > 1 && viewModel.messages.count%2 == 0{
                if let content = newValue.last?.content {
                    speechModel.speechText(to: content)
                }
            }
        })
        .onChange(of: self.storyCount) { count in
            if count > 3 {
                isEnd = true
            }
        }
        .onDisappear {
            for message in viewModel.messages[1...] {
                user.chapters.append(Chapter(story: message.content))
            }
        }
    }
}

//struct MakeStoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            MakeStoryView()
//        }
//        .environmentObject(User(name: "Hansol", title: "어쩌구저쩌구"))
//    }
//}
