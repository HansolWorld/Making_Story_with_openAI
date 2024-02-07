//
//  MakeStoryCanvasView.swift
//  Generative_test
//
//  Created by apple on 2023/08/28.
//

import SwiftUI

struct MakeStoryCanvasView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var user: User
    @State var canvas: CanvasView = CanvasView()
    var storyCount: Int
    @State var speechModel = SpeechModel()
    var body: some View {
        ZStack {
            Color("background")
            VStack(alignment: .leading) {
                canvas
                    .frame(height: UIScreen.main.bounds.height/2)
                    .padding(.bottom, 36)
                Spacer()
                HStack {
                    Button(action: {
                        speechModel.speechStop()
                        dismiss()
                    }) {
                        ButtonImage(systemName: "chevron.left", disabled: storyCount == 0)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        speechModel.speechStop()
                    })
                    .disabled(storyCount == 0)
                    Spacer()
                    if storyCount < user.chapters.count-1 {
                        NavigationLink(destination: MakeStoryCanvasView(storyCount: storyCount+1)) {
                            ButtonImage(systemName: "chevron.right", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            speechModel.speechStop()
                        })
                    } else {
                        NavigationLink(destination: MakeCoverView()) {
                            ButtonImage(systemName: "chevron.right", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            speechModel.speechStop()
                        })
                    }
                }
            }
            .padding(.vertical, 88)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct MakeStoryCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MakeStoryCanvasView( storyCount: 0)
                .environmentObject(User(name: "한솔", title: "누구의동화", chapters: [
                    Chapter(story: "옛날 옛날에"),
                    Chapter(story: "아주 먼 옛날에"),
                    Chapter(story: "멀고 먼 옛날에"),
                    Chapter(story: "끝")]))
        }
    }
}
