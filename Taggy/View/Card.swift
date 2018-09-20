import PureLayout

class Card: NSCollectionViewItem {
    let labelView = NSTextView()
    let linkView = NSTextView()
    let textView = NSTextView()
    
    var data: (type: String, label: String?, text: String, link: String?, tags: [String])? {
        didSet {
            guard isViewLoaded else { return }
            
            if ((data?.text) != nil) {
               configureView()
            }
        }
    }
    
    func configureLabelView() {
        let string = (data?.label)!
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.setAttributes(
            [
                .font: NSFont(name: "SF Pro Display Medium", size: 15)!,
                .foregroundColor: NSColor.textPrimary
            ],
            range: NSRange(location: 0, length: string.count)
        )
        
        labelView.textStorage?.setAttributedString(attributedString)
        
        labelView.isEditable = false
        labelView.isFieldEditor = false
        
        view.addSubview(labelView)
        
        labelView.autoSetDimension(.height, toSize: 16)
        labelView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        labelView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        labelView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    }
    
    func configureLinkView() {
        let string = (URL(string: (data?.link)!)?.host)!
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.setAttributes(
            [
                .font: NSFont(name: "SF Pro Display", size: 13)!,
                .foregroundColor: NSColor.textPrimary,
                .link: URL(string: (data?.link)!)!
            ],
           range: NSRange(location: 0, length: string.count)
        )
        
        linkView.textStorage?.setAttributedString(attributedString)
        
        linkView.linkTextAttributes = [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        
        linkView.isEditable = false
        linkView.isFieldEditor = false
        
        view.addSubview(linkView)
        
        linkView.autoSetDimension(.height, toSize: 16)
        linkView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        linkView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        linkView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    }
    
    func configureTextView() {
        let string = (data?.text)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.3
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.setAttributes(
            [
                .font: NSFont(name: "SF Pro Display", size: 13)!,
                .foregroundColor: NSColor.textPrimary,
                .paragraphStyle: paragraphStyle
            ],
            range: NSRange(location: 0, length: string.count)
        )
        
        textView.textStorage?.setAttributedString(attributedString)
        
        textView.isEditable = false
        textView.isFieldEditor = false
        
        view.addSubview(textView)
        
        if data?.label != nil && (data?.label?.count)! > 0 {
            configureLabelView()
            
            textView.autoPinEdge(.top, to: .bottom, of: labelView, withOffset: 10)
        } else {
            textView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        }
        
        if data?.link != nil && (data?.link?.count)! > 0 && data?.type == "link" {
            configureLinkView()
            
            textView.autoPinEdge(.bottom, to: .top, of: linkView, withOffset: -10)
        } else {
            textView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        }
        
        textView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        textView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    }
    
    func configureView() {
        view.wantsLayer = true
        view.layer?.borderColor = NSColor(hex: "f5f5f5").cgColor
        view.layer?.borderWidth = 1
    
        configureTextView()
    }
    
    override func mouseMoved(with event: NSEvent) {
        NSCursor.pointingHand.set()
    }
    
    override func mouseDown(with event: NSEvent) {
       
    }
}
