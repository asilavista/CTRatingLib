//
//  RatingView.swift
//  CTRating
//
//  Created by Asi Givati on 21/12/2024.
//

import SwiftUI

public struct RatingView: View {
    
    var maxRating:Int
    @Binding var currentRating:Int
    var animation:Animation?
    var width:CGFloat
    var color:Color
    var ratingImage:RatingImage
    
    /// - Parameters:
    ///   - maxRating: The maximum rating on the scale
    ///   - currentRating: A binding to the current rating variable
    ///   - width: The width of the image used for the rating (Default - 20)
    ///   - color: The color of the image ( (Default - system Yellow)
    ///   - An enum representing the image used for the rating (Default - star)
    ///  Only two required parameters are maxRating and the binding to currentRating. All other parameters have default
    public init(maxRating: Int, currentRating: Binding<Int>, width: CGFloat = 20, color: Color = .yellow, ratingImage: RatingImage = .star, animation:Animation?) {
        self.maxRating = maxRating
        _currentRating = currentRating
        self.width = width
        self.color = color
        self.ratingImage = ratingImage
        self.animation = animation
    }
    
    public var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { rating in
                correctImage(for: rating)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: width)
                    .ifNotNil(animation) { view, animation in
                        view.animation(animation, value: currentRating)
                    }
                    .onTapGesture {
                        currentRating = rating
                    }
            }
        }
    }
    
    func correctImage(for rating:Int) -> Image {
        ratingImage.image(fill: rating <= currentRating)
    }
}

extension View {
    @ViewBuilder func ifNotNil<Content:View, Item:Any>(_ item:Item?, content:(Self, Item) -> (Content)) -> some View {
        if let item {
            content(self, item)
        } else {
            self
        }
    }
}

#Preview("RatingView Preview") {
    @Previewable @State var currentRating = 3
    RatingView(maxRating: 5, currentRating: $currentRating, width: 28, animation: .easeInOut)
}
