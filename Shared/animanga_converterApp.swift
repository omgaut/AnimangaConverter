//
//  animanga_converterApp.swift
//  Shared
//
//  Created by Om Gautam on 8/10/22.
//

import SwiftUI
import GoogleMobileAds

@main
struct animanga_converterApp: App {
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
