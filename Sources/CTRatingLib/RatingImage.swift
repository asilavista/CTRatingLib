//
//  RatingImage.swift
//  CTRating
//
//  Created by Asi Givati on 21/12/2024.
//

import SwiftUI

public enum RatingImage: String {
    // These represent FSymbols. the string after the SF_ suffix is the name of the SFSymbol. there must also be a corresponding .fill suffix.
    case star = "SF_star"
    case heart = "SF_heart"
    case thumbsUp = "SF_hand.thumbsup"
    case bookmark = "SF_bookmark"
    case flag = "SF_flag"
    case bell = "SF_bell"
    // These are images stored in the bundle. There must be one with the corresponding name along with one with the .fill suffix.
    // All images should be stored as a Template images, rendered as Single Scale.
    case baseball
    case basketball
    case football
    
    public func image(fill:Bool) -> Image {
        var name = rawValue + (fill ? ".fill" : "")
        let sfSymbol = "SF_"
        let isSfSymbol = rawValue.hasPrefix(sfSymbol)
        if isSfSymbol {
            name = name.replacingOccurrences(of: sfSymbol, with: "")
        }
        return isSfSymbol ? Image(systemName: name) : Image(name, bundle: .module)
    }
}
