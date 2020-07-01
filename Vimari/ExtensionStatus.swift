//
//  ExtensionStatus.swift
//  Vimari
//
//  Created by Nick Belzer on 01/07/2020.
//  Copyright © 2020 net.televator. All rights reserved.
//

import SafariServices.SFSafariApplication

struct SFSafariServicesNotAvailable: Error {}

struct ExtensionStatus {
    /**
     Retrieve the status of the extension.
     
     - parameters:
        - extensionIdentifier: The identifier of the extension.
        - completionHandler: Function called when the status is retrieved.
     
     Retrieves the status (enabled/not) from the SFSafariExtensionManager in an asynchronous manner.
     */
    func retrieveStatus(extensionIdentifier: String, completionHandler: @escaping (Bool?, Error?) -> Void) {
        NSLog("Refreshing Extension Status")
        if SFSafariServicesAvailable() {
            SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionIdentifier) { state, error in
                print("State", state as Any, "Error", error as Any, state?.isEnabled as Any)

                if let error = error {
                    completionHandler(nil, error)
                }
                if let state = state {
                    completionHandler(state.isEnabled, nil)
                }
            }
        } else {
            NSLog("SFSafariServices not available")
            completionHandler(nil, SFSafariServicesNotAvailable())
        }
    }
}
