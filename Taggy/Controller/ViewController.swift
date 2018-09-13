import Cocoa

class ViewController: NSViewController {
    let collectionView = NSCollectionView()
    
    let cardId = NSUserInterfaceItemIdentifier("cardId")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.identifier = cardId
        collectionView.collectionViewLayout = NSCollectionViewFlowLayout();
        
        collectionView.frame = NSRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = NSNib(nibNamed: NSNib.Name(rawValue: "Card"), bundle: nil)
        collectionView.register(nib, forItemWithIdentifier: cardId)
        
        view.addSubview(collectionView)
    }
}

extension ViewController: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let card = collectionView.makeItem(withIdentifier: cardId, for: indexPath)

        return card
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: 100, height: 100)
    }
}





