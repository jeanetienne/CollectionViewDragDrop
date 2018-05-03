//
// CollectionViewDragDrop
// Copyright © 2018 Jean-Étienne. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var collectionView: CustomCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.registerForDraggedTypes([.string])
        collectionView.setDraggingSourceOperationMask(.every, forLocal: true)
        collectionView.setDraggingSourceOperationMask(.every, forLocal: false)
    }

}

extension ViewController: NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        highlightItems(true, at: indexPaths)
    }

    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        highlightItems(false, at: indexPaths)
    }

    // Drag
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let wallpaperName = wallpapers[indexPath.item].name()?.rawValue ?? "unknown"
        return wallpaperName as NSString
    }

    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexPaths: Set<IndexPath>) {
        // This seems to be overriden by NSCollectionView's default NSDraggingDestination implementation.
        // The draggingFormation never appear to be "pile" when the NSCollectionView is the drop destination.
        session.draggingFormation = .pile
    }

    // Drop
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        if proposedDropOperation.pointee == .on {
            proposedDropOperation.pointee = .before
        }
        return .move
    }

}

extension ViewController: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CustomCollectionViewItem"), for: indexPath)
        guard let collectionViewItem = item as? CustomCollectionViewItem else { return item }
        collectionViewItem.imageView?.image = wallpapers[indexPath.item]
        collectionViewItem.textField?.stringValue = wallpapers[indexPath.item].name()?.rawValue ?? "unknown"
        return collectionViewItem
    }

}

extension ViewController {

    func highlightItems(_ highlighted: Bool, at indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            guard let item = collectionView.item(at: indexPath) as? CustomCollectionViewItem else { continue }
            item.setHighlighted(highlighted)
        }
    }

    var wallpapers: [NSImage] {
        return [
            NSImage(named: NSImage.Name(rawValue: "abstract-shapes"))!,
            NSImage(named: NSImage.Name(rawValue: "abstract"))!,
            NSImage(named: NSImage.Name(rawValue: "antelope-canyon"))!,
            NSImage(named: NSImage.Name(rawValue: "bahamas-aerial"))!,
            NSImage(named: NSImage.Name(rawValue: "blue-pond"))!,
            NSImage(named: NSImage.Name(rawValue: "color-burst-1"))!,
            NSImage(named: NSImage.Name(rawValue: "color-burst-2"))!,
            NSImage(named: NSImage.Name(rawValue: "color-burst-3"))!,
            NSImage(named: NSImage.Name(rawValue: "death-valley"))!,
            NSImage(named: NSImage.Name(rawValue: "desert"))!,
            NSImage(named: NSImage.Name(rawValue: "earth-and-moon"))!,
            NSImage(named: NSImage.Name(rawValue: "earth-horizon"))!,
            NSImage(named: NSImage.Name(rawValue: "elephant"))!,
            NSImage(named: NSImage.Name(rawValue: "floating-ice"))!,
            NSImage(named: NSImage.Name(rawValue: "foggy-forest"))!,
            NSImage(named: NSImage.Name(rawValue: "foxtail-barley"))!,
            NSImage(named: NSImage.Name(rawValue: "high-sierra"))!,
            NSImage(named: NSImage.Name(rawValue: "ink-cloud"))!,
            NSImage(named: NSImage.Name(rawValue: "lake"))!,
            NSImage(named: NSImage.Name(rawValue: "milky-way"))!,
            NSImage(named: NSImage.Name(rawValue: "mountain-range"))!,
            NSImage(named: NSImage.Name(rawValue: "poppies"))!,
            NSImage(named: NSImage.Name(rawValue: "rice-paddy"))!,
            NSImage(named: NSImage.Name(rawValue: "rolling-waves"))!,
            NSImage(named: NSImage.Name(rawValue: "sierra-2"))!,
            NSImage(named: NSImage.Name(rawValue: "sierra"))!,
            NSImage(named: NSImage.Name(rawValue: "wave"))!,
            NSImage(named: NSImage.Name(rawValue: "yosemite-2"))!,
            NSImage(named: NSImage.Name(rawValue: "yosemite-3"))!,
            NSImage(named: NSImage.Name(rawValue: "yosemite-4"))!,
            NSImage(named: NSImage.Name(rawValue: "yosemite-5"))!,
            NSImage(named: NSImage.Name(rawValue: "yosemite"))!
        ]
    }

}
