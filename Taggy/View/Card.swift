import Cocoa

class Card: NSCollectionViewItem {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = NSTextView()
        
        textView.frame = NSRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        textView.isEditable = false
        textView.isFieldEditor = false
        
        textView.string = "Hello world"
        
        view.addSubview(textView)
    }
}
