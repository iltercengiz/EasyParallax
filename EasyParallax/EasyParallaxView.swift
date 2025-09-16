//
//  EasyParallaxView.swift
//  EasyParallax
//
//  Created by Ilter Cengiz on 26/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct EasyParallaxView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var initialOffset: CGFloat = 0
    
    private let stretchMultiplier: CGFloat = 1.0
    private let baseImageHeight: CGFloat = 269
    private let minimumImageHeight: CGFloat = 56
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Sticky header image (always at top)
                Image("Pikachu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: imageHeight)
                    .background(Color(red: 0.18, green: 0.8, blue: 0.44))
                    .clipped()
                
                // ScrollView with content that scrolls behind the image
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Spacer to account for the image height
                        Color.clear
                            .frame(height: baseImageHeight)
                        
                        // Text content
                        VStack(alignment: .leading, spacing: 15) {
                            Text("""
Pikachu is a short, chubby rodent Pokémon. It is covered in yellow fur with two horizontal brown stripes on its back. It has a small mouth, long, pointed ears with black tips, brown eyes, and two red circles on its cheeks. There are pouches inside its cheeks where it stores electricity. It has short forearms with five fingers on each paw, and its feet each have three toes. At the base of its lightning bolt-shaped tail is patch of brown fur at the base. A female will have a V-shaped notch at the end of its tail, which looks like the top of a heart. It is classified as a quadruped, but it has been known to stand and walk on its hind legs.

The anime has shown that Pikachu sometimes travel in groups. It raises its tail to check its surroundings, and is occasionally struck by lightning in this position. Living in forested areas, Pikachu is found foraging for berries it roasts with electricity to make them tender enough to eat. It has been observed eating and sometimes destroying telephone poles, wires, and other electronic equipment.

Pikachu is able to release electric discharges of varying intensity. Pikachu has been known to build up energy in its glands, and will need to discharge to avoid complications. It is also able to release energy through its tail, which acts as a grounding rod, as well as recharging fellow Pikachu with electric shocks. Pikachu can also electrify itself to use its signature move Volt Tackle. When threatened, it looses electric charges from its sacs, and a group can build and cause lightning storms. It is found mostly in forests, where a sure sign that Pikachu inhabits a location is patches of burnt grass.

From: Bulbapedia
""")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                        .background(Color.white)
                        .background(
                            GeometryReader { scrollGeometry in
                                Color.clear.preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: -scrollGeometry.frame(in: .named("scroll")).minY
                                )
                            }
                        )
                    }
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                .opacity(0.5)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    private var parallaxOffset: CGFloat {
        let offset = scrollOffset - initialOffset
        return offset * 0.5
    }
    
    private var imageHeight: CGFloat {
        let offset = scrollOffset
        
        // When pulling down (negative scroll offset), stretch the image
        if offset < 0 {
            return baseImageHeight + (abs(offset) * stretchMultiplier)
        }
        // When scrolling up (positive scroll offset), shrink but maintain minimum
        else if offset > 0 {
            let shrunkHeight = baseImageHeight - offset
            return max(shrunkHeight, minimumImageHeight)
        }
        
        return baseImageHeight
    }
}

#Preview {
    EasyParallaxView()
}
