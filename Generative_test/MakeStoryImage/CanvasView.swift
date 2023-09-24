//
//  CanvasView.swift
//  Generative_test
//
//  Created by apple on 2023/08/26.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pencil
    
    var body: some View {
        DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
            .navigationTitle("Drawing")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                isDraw = false
            }) {
                Image(systemName: isDraw ? "pencil" : "pencil.slash")
                    .font(.title)
            }, trailing: HStack(spacing: 15, content: {
                ColorPicker(selection: $color) {
                    EmptyView()
                }
                Menu {
                    Button(action: {
                        isDraw = true
                        type = .pencil
                    }) {
                        Label {
                            Text("Pencil")
                        } icon: {
                            Image(systemName: "pencil")
                        }
                    }
                    
                    Button(action: {
                        isDraw = true
                        type = .pen
                    }) {
                        Label {
                            Text("Pen")
                        } icon: {
                            Image(systemName: "pencil.line")
                        }
                    }
                    
                    Button(action: {
                        isDraw = true
                        type = .marker
                    }) {
                        Label {
                            Text("Marker")
                        } icon: {
                            Image(systemName: "highlighter")
                        }
                    }
                } label: {
                    Image(systemName: "pencil.tip")
                        .font(.title)
                }
            }))
    }
    
    func saveImage() -> Image {
        let image = canvas.drawing.image(from: canvas.frame, scale: 1)
        
        return Image(uiImage: image)
    }
}


struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    
    var ink: PKInkingTool {
        PKInkingTool(type, color: UIColor(color))
    }
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        uiView.tool = isDraw ? ink : eraser
    }
}
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CanvasView()
        }
        .navigationViewStyle(.stack)
    }
}
