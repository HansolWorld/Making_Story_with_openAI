//
//  User.swift
//  Generative_test
//
//  Created by apple on 2023/08/28.
//

import SwiftUI


class User: ObservableObject {
    var name: String?
    var title: String?
    var coverImage: Image?
    var chapters: [Chapter]
    
    init(name: String? = nil, title: String? = nil, coverImage: Image? = nil,chapters: [Chapter] = []) {
        self.name = name
        self.title = title
        self.coverImage = coverImage
        self.chapters = chapters
    }
    
    func getStroy(at index: Int ) -> String {
        return chapters[index].story
    }
    
    func getImage(at index: Int ) -> Image {
        return chapters[index].image ?? Image("")
    }
    
    func getChapter(at index: Int ) -> Chapter {
        return chapters[index]
    }
    
    func reset() {
        self.name = nil
        self.title = nil
        self.coverImage = nil
        self.chapters = []
    }
}

struct Chapter {
    var story: String
    var image: Image?
}

