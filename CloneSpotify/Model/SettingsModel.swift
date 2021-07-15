//
//  SettingsModel.swift
//  CloneSpotify
//
//  Created by lov niveriya on 13/07/21.
//

import Foundation

struct SectionsForSetting {
    let title:String
    let Options:[Options]
}
struct Options {
    let title:String
    let handler:()->Void
}
