//
//  Flickr_IOSApp.swift
//  Flickr-IOS
//
//  Created by fgrmac on 31/05/24.
//

import SwiftUI

@main
struct Flickr_IOSApp: App {
    @StateObject private var vm = FlickrViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(vm)
    }
}
