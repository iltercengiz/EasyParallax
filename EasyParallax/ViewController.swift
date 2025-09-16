//
//  ViewController.swift
//  EasyParallax
//
//  Created by Ilter Cengiz on 26/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupView()
    }

    func setupView() {
        let scrollView = setupScrollView()
        setupContent(in: scrollView)
    }

    func setupScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return scrollView
    }

    func setupContent(in scrollView: UIScrollView) {
        let imageView = UIImageView(image: UIImage(named: "Pikachu"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 0.18, green: 0.8, blue: 0.44, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = """
Pikachu is a short, chubby rodent Pokémon. It is covered in yellow fur with two horizontal brown stripes on its back. It has a small mouth, long, pointed ears with black tips, brown eyes, and two red circles on its cheeks. There are pouches inside its cheeks where it stores electricity. It has short forearms with five fingers on each paw, and its feet each have three toes. At the base of its lightning bolt-shaped tail is patch of brown fur at the base. A female will have a V-shaped notch at the end of its tail, which looks like the top of a heart. It is classified as a quadruped, but it has been known to stand and walk on its hind legs.

The anime has shown that Pikachu sometimes travel in groups. It raises its tail to check its surroundings, and is occasionally struck by lightning in this position. Living in forested areas, Pikachu is found foraging for berries it roasts with electricity to make them tender enough to eat. It has been observed eating and sometimes destroying telephone poles, wires, and other electronic equipment.

Pikachu is able to release electric discharges of varying intensity. Pikachu has been known to build up energy in its glands, and will need to discharge to avoid complications. It is also able to release energy through its tail, which acts as a grounding rod, as well as recharging fellow Pikachu with electric shocks. Pikachu can also electrify itself to use its signature move Volt Tackle. When threatened, it looses electric charges from its sacs, and a group can build and cause lightning storms. It is found mostly in forests, where a sure sign that Pikachu inhabits a location is patches of burnt grass.

From: Bulbapedia
"""
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)

        stackView.addArrangedSubview(label)
        scrollView.addSubview(stackView)
        scrollView.addSubview(imageView)

        let imageBottomConstraint = imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10)
        imageBottomConstraint.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            imageBottomConstraint,
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 360),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
