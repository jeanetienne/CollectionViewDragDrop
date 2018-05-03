//
// CollectionViewDragDrop
// Copyright © 2018 Jean-Étienne. All rights reserved.
//

import Cocoa

class CustomCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlColor.cgColor
        view.layer?.borderWidth = 0.0
        view.layer?.borderColor = NSColor.alternateSelectedControlColor.cgColor
    }

    func setHighlighted(_ highlighted: Bool) {
        view.layer?.borderWidth = highlighted ? 3.0 : 0.0
    }

}
