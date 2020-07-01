import Cocoa
import SafariServices.SFSafariApplication
import OSLog
import SwiftUI

@available(OSX 10.15.0, *)
class ViewController: NSViewController {
    lazy var container = NSHostingController(rootView: ConfigurationView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(container)
        view.addSubview(container.view)
        container.view.translatesAutoresizingMaskIntoConstraints = false
        container.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        container.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
