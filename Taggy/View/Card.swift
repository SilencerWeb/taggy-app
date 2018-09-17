import Cocoa
import PureLayout

class Card: NSCollectionViewItem {
    let labelView = NSTextView()
    let linkView = NSTextView()
    let textView = NSTextView()
    
    var data: (type: String, label: String?, text: String, link: String?, tags: [String])?
    
    func configureLabelView() {
        labelView.font = NSFont(name: "SF Pro Display Medium", size: 15)
        labelView.isEditable = false
        labelView.isFieldEditor = false
        labelView.isHidden = false
        
        labelView.string = (data?.label)!
        
        labelView.autoSetDimension(.height, toSize: 16)
        labelView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        labelView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        labelView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    }
    
    func configureLinkView() {
        linkView.font = NSFont(name: "SF Pro Display", size: 13)
        linkView.isEditable = false
        linkView.isFieldEditor = false
        linkView.isHidden = false
        
        linkView.string = (URL(string: (data?.link)!)?.host)!
        
        let attributedString = NSMutableAttributedString(string: linkView.string)
        let range = NSRange(location: 0, length: linkView.string.count)
        let url = URL(string: (data?.link)!)
        
        attributedString.setAttributes([.link: url!], range: range)
        linkView.textStorage?.setAttributedString(attributedString)
        
        linkView.linkTextAttributes = [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        
        linkView.autoSetDimension(.height, toSize: 16)
        linkView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        linkView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        linkView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    }
    
    func configureTextView() {
        textView.font = NSFont(name: "SF Pro Display", size: 13)
        textView.textContainer?.lineBreakMode = .byTruncatingTail
        textView.isEditable = false
        textView.isFieldEditor = false
        
        textView.string = (data?.text)!
        
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
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.layer?.borderWidth = 1
        view.layer?.borderColor = .black
        
        view.addSubview(labelView)
        view.addSubview(textView)
        view.addSubview(linkView)
        
        labelView.isHidden = true
        linkView.isHidden = true
        
        configureTextView()
    }
}
