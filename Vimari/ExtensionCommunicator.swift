//
//  ExtensionCommunicator.swift
//  Vimari
//
//  Created by Nick Belzer on 01/07/2020.
//  Copyright © 2020 net.televator. All rights reserved.
//

import Foundation
import SafariServices.SFSafariApplication

struct ExtensionCommunicator {
    let extensionIdentifier: String

    /**
     Dispatch a message to the connected Extension.
     
     - parameters:
        - messageName: The type of messsage to send.
     
     The connected extension is defined by the `.extensionIdentifier`.
     */
    func sendMessageToExtension(messageName: String) {
        SFSafariApplication.dispatchMessage(
            withName: messageName,
            toExtensionWithIdentifier: extensionIdentifier,
            userInfo: nil) { (error) in
                if let error = error {
                    NSLog(error.localizedDescription)
                }
        }
    }
}
