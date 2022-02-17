//
//  TimbreDrawer.swift
//  visualizer
//
//  Created by Mark Cheng on 15/2/2022.
//

import Foundation

struct TimbreDrawer: Codable {
    var selected: InstrumentTypes
    
    static let `default` = TimbreDrawer(
        selected: .piano
    )
    
    enum InstrumentTypes: String, Identifiable, Codable {
        case piano
        case violin
        case cello
        case guitar
        
        var id: String { rawValue }
        
        var label: String {
            switch self {
            case .piano: return "Piano"
            case .violin: return "Violin"
            case .cello: return "Cello"
            case .guitar: return "Guitar"
            }
          }
        
        var icon: String {
            switch self {
            case .piano: return "pianokeys"
            case .violin: return "violin"
            case .cello: return "cello"
            case .guitar: return "guitars"
            }
        }
    }
}
