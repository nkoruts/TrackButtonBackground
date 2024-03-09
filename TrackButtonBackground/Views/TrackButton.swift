//
//  NextTrackButton.swift
//  TrackButtonBackground
//
//  Created by Nikita Koruts on 09.03.2024.
//

import SwiftUI

struct NextTrackButton: View {
    @State private var isClicked = false
    
    private let imageSize: CGFloat = 42
    
    var body: some View {
        Button {
            withAnimation(.spring(dampingFraction: 0.5)) {
                isClicked = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isClicked = false
            }
        } label: {
            HStack(spacing: .zero) {
                PlayImage()
                    .opacity(isClicked ? 1 : 0)
                    .frame(width: isClicked ? imageSize : 0)
                PlayImage()
                    .frame(width: imageSize)
                PlayImage()
                    .opacity(isClicked ? 0 : 1)
                    .frame(width: isClicked ? 0 : imageSize)
            }
        }
        .buttonStyle(NextAnimationStyle())
    }
}

struct NextAnimationStyle: ButtonStyle {
    @State private var isAnimated = false
    
    private let animationDuration: CGFloat = 0.22
    private let scaleValue: CGFloat = 0.86
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Circle()
                    .fill(.gray.opacity(0.25))
                    .frame(width: 130, height: 130)
                    .opacity(isAnimated ? 1 : 0)
            )
            .scaleEffect(isAnimated ? scaleValue : 1)
            .animation(.spring(response: animationDuration), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed {
                    withAnimation(.spring(response: animationDuration)) {
                        isAnimated = true
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        withAnimation(.spring(response: animationDuration)) {
                            isAnimated = false
                        }
                    }
                }
            }
    }
}
