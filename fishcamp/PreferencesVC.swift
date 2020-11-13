//
//  PreferencesView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/10/20.
//

import Foundation
import Cocoa

class PreferencesView: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.styleMask = [.closable, .titled]
    }
}
