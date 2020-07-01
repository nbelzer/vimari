//
//  ConfigurationView.swift
//  Vimari
//
//  Created by Nick Belzer on 01/07/2020.
//  Copyright © 2020 net.televator. All rights reserved.
//

import SwiftUI
import Cocoa
import SafariServices.SFSafariApplication


private enum Constant {
    static let extensionIdentifier = "net.televator.Vimari.SafariExtension"
    static let openSettings = "openSettings"
    static let resetSettings = "resetSettings"
}


@available(OSX 10.15.0, *)
struct ConfigurationView: View {
    @State var status: String = "Initial Status"
    private var version: String {
        get {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }
    }
    var body: some View {
        HStack {
            VStack {
                Image("Logo")
                Text("Vimari \(version)")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: refreshExtensionStatus) {
                            Image(nsImage: NSImage(named: "NSRefreshTemplate")!)
                        }
                        Text("Status: \(status)")
                    }
                        
                    Button("Open Safari Extension Preferences", action: openSafariExtensionPreferences)
                }
                .padding(.bottom)
                Button("Open Configuration File", action: dispatchOpenSettings)
                Button("Reset Configuration", action: dispatchResetSettings)
            }
        }
        .padding(.all, 16)
        .onAppear(perform: refreshExtensionStatus)
    }
    
    /**
     Refresh the extension status.
     */
    func refreshExtensionStatus() {
        ExtensionStatus().retrieveStatus(extensionIdentifier: Constant.extensionIdentifier) { status, error in
            if let error = error {
                self.status = error.localizedDescription
            } else if let status = status {
                self.status = status ? "Enabled" : "Disabled"
            }
        }
    }
    
    /**
     Dispatch message to "Vimari Extension" target to open Settings.
     */
    func dispatchOpenSettings() {
        ExtensionCommunicator(extensionIdentifier: Constant.extensionIdentifier).sendMessageToExtension(messageName: Constant.openSettings)
    }
    
    /**
     Dispatch message to "Vimari Extension" target to reset Settings.
     */
    func dispatchResetSettings() {
        ExtensionCommunicator(extensionIdentifier: Constant.extensionIdentifier).sendMessageToExtension(messageName: Constant.resetSettings)
    }
    
    /**
     Open Safari Preferences for "Vimari Extension".
     */
    func openSafariExtensionPreferences() {
        SFSafariApplication.showPreferencesForExtension(
            withIdentifier: Constant.extensionIdentifier) { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.
            }
        }
    }
}

@available(OSX 10.15.0, *)
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfigurationView()
        }
    }
}
