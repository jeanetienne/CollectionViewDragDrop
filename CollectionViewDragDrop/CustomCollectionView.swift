//
// CollectionViewDragDrop
// Copyright © 2018 Jean-Étienne. All rights reserved.
//

import Cocoa

class CustomCollectionView: NSCollectionView {

    // Defined in NSDraggingDestination protocol, which NSCollectionView provides a default implementation for
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return super.draggingEntered(sender)
//        return .move
    }

}
