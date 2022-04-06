//
//  TypeExtension.swift
//  visualizer
//
//  Created by Mark Cheng on 6/4/2022.
//

import Foundation

extension Array {
    subscript( circular index: Int ) -> Element {
        let modIndex = isEmpty ? 0 : index % count
        return self[ modIndex < 0 ? modIndex + count : modIndex ]
    }
}
