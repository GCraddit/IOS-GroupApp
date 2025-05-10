//
//  AppStyle.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct AppStyle {
    // Layout
    static let cardCornerRadius: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let sectionSpacing: CGFloat = 20

    // Color
    static let primaryColor = Color.blue
    static let secondaryText = Color.gray
    static let backgroundColor = Color(.systemBackground)
    static let highlight = Color.orange

    // Shadow
    static let cardShadow = Color.black.opacity(0.05)
    static let cardShadowRadius: CGFloat = 4

    // Font
    static let headingFont = Font.title2.weight(.bold)
    static let captionFont = Font.caption
}

