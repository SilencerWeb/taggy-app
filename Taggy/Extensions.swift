import Cocoa

extension NSColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff00) / 255
                    a = 1
                    
                    print(r, g, b, a)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    
                    return
                }
            }
        }
        
        return nil
    }
}
