//
//  ContentView.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import SwiftMovable
import SwiftUI

enum ControlKind: Int, CaseIterable {
    case background
    case item
    case sticker
    case text

    var icon: String {
        switch self {
        case .background:
            return "paintpalette"
        case .item:
            return "tshirt"
        case .sticker:
            return "tag"
        case .text:
            return "textformat"
        }
    }

    var label: String {
        switch self {
        case .background:
            return "背景"
        case .item:
            return "衣橱"
        case .sticker:
            return "贴纸"
        case .text:
            return "文字"
        }
    }
}

struct ContentView: View {
    let ratio: CGFloat = 2.0 / 3.0

    @State private var toggle = false

    @State private var showControl: ControlKind? = nil

    @State private var text = "点击编辑文字"

    @FocusState private var focused

    @State private var backgroundViewModel = BackgroundViewModel()

    @State private var movablesViewModel = MovablesViewModel()

    @State private var bottomHeight: CGFloat = 100

    @State private var showFullScreen = false
    @State private var showTextSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                CardView(backgroundViewModel: backgroundViewModel, movablesViewModel: movablesViewModel, selection: $selection)
                Spacer()
                controlPanel.transition(.move(edge: .bottom))
            }
            .environment(\.dismissPicker, {
                withAnimation {
                    showControl = nil
                }
            })
            .fullScreenCover(isPresented: $showFullScreen, content: {
                VStack {
                    Button {
                        withAnimation {
                            showFullScreen = false
                        }
                    } label: {
                        Text("关闭")
                    }
                }
            })
            .sheet(isPresented: $showTextSheet, content: {
                VStack {
                    TextField(text: $text) {
                        Text("文本")
                    }
                    Spacer()
                }
            })

            .ignoresSafeArea(.container, edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                    } label: {
                        Text("保存")
                    }
                }
            }
        }
    }

    @State private var selection: UUID?

    var controlPanel: some View {
        Group {
            if let control = showControl {
                controlView(for: control)
            } else {
                bottom
            }
        }
    }

    func controlView(for control: ControlKind) -> some View {
        Group {
            switch control {
            case .background:
                BackgroundPickerView(viewModel: backgroundViewModel)
            case .item:
                Text("衣橱")
            case .sticker:
                Text("贴纸")
            case .text:
                VStack {
                    HStack {
                        Text("双击修改文字")
                            .onTapGesture {
                                showTextSheet = true
                            }

                        Button {
                            withAnimation {
                                showControl = nil
                            }
                        } label: {
                            Text("收起")
                        }.buttonStyle(CapsuleButtonStyle())
                    }

                    Rectangle().fill(.red.opacity(0.1))
                }
            }
        }
        .padding(.top, 8)
        .frame(height: 250)
    }

    var bottom: some View {
        HStack {
            ForEach(ControlKind.allCases, id: \.self) { kind in
                controlButton(for: kind)
            }
        }
        .padding(.vertical, 10)
        .background(.lightCyan)
    }

    func controlButton(for kind: ControlKind) -> some View {
        Button {
            withAnimation {
                switch kind {
                case .background, .sticker, .text:
                    showControl = kind

                case .item:
                    showFullScreen = true
                }
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: kind.icon)
                Text(kind.label)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
}


struct CardView: View {
    var backgroundViewModel: BackgroundViewModel
    var movablesViewModel: MovablesViewModel
    @Binding var selection: UUID?

    var body: some View {
        GeometryReader { proxy in
            let size = getSize(size: proxy.size)
            backgroundViewModel.backgroundView()

                .overlay {
                    ForEach(movablesViewModel.images) { movbleImage in

                        MovableObjectView(item: movbleImage, selection: $selection, config: stickerConfig) { _ in
                            Image(systemName: "cat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .frame(width: size.width, height: size.height)
                .position(x: proxy.size.width / 2, y: size.height / 2)
        }
    }

    let ratio: CGFloat = 2.0 / 3.0

    func getSize(size: CGSize) -> CGSize {
        let width = size.width
        let height = size.height

        if height * ratio > width {
            return .init(width: size.width, height: size.width / ratio)
        } else {
            return .init(width: height * ratio, height: height)
        }
    }

    let stickerConfig = MovableObjectViewConfig(
        enable: true,
        deleteCallback: { _ in
        },
        editCallback: { _ in
        }
    )
}
