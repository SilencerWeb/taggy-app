import PureLayout

class ViewController: NSViewController {
    let searchView = NSView()
    let search = NSTextField()
    var searchingString: String?
    
    let cardList = NSCollectionView()
    
    let cardId = NSUserInterfaceItemIdentifier("CardID")
    
    let cardsData: [(type: String, label: String?, text: String, link: String?, tags: [String])] = [
        (
            type: "text",
            label: nil,
            text: "Alternatively one can use paddle.com - They charge a higher fee, tho.",
            link: nil,
            tags: ["#text"]
        ),
        (
            type: "text",
            label: "Essential YC Advice",
            text:
                """
                1. Запускайся как можно раньше. Запустить посредственный продукт и постепенно изменять его через общение с пользователями лучше, чем в одиночку доводить свой проект до «идеального».
                2. Работай над тем, что действительно нужно людям.
                3. Делай вещи, которые не масштабируются.
                4. Найди решение «90/10». 90/10 — это когда ты можешь на 90% решить проблему пользователя, приложив всего 10% усилий.
                5. Найди 10-100 пользователей, которым по-настоящему нужен твой продукт. Маленькая группа людей, которые тебя любят, лучше большой группы, которым ты просто нравишься.
                6. На каком-то этапе каждый стартап имеет нерешенные проблемы. Успех определяется не тем, есть ли у тебя изначально такие проблемы, а что ты делаешь, чтобы их как можно быстрее решить.
                7. Не масштабируй свою команду и продукт, пока ты не построил что-то, что нужно людям.
                8. Стартапы в любой момент времени могут хорошо решать только одну проблему.
                9. Игнорируй своих конкурентов. В мире стартапов ты скорее умрешь от суицида, чем от убийства.
                10. Будь хорошим человеком. Ну или хотя бы просто не будь придурком.
                11. Спи достаточное количество времени и занимайся спортом.

                Многие пункты подробно расписаны здесь:
                http://blog.ycombinator.com/ycs-essential-startup-advice/
                """,
            link: nil,
            tags: ["#text", "#advice", "#launch", "#startup_hero", "#telegram_channel"]
        ),
        (
            type: "text",
            label: nil,
            text:
                """
                If I was you, I'd start trying to build a small following.
                it helps a lot (especially if your making products for makers)

                Indie Hackers / Reddit Startup + Side Project great places ...
                And slowly but surely you'll build twitter + email list.
                follow @AndreyAzimov example! with his medium posts + twitter
                """,
            link: nil,
            tags: ["#text", "#advice"]
        ),
        (
            type: "link",
            label: "Paddle",
            text: "Like Stripe but maybe avaliable in Uzbekistan and Russia",
            link: "https://paddle.com/",
            tags: ["#link", "#payment", "#payment_service"]
        ),
        (
            type: "link",
            label: "How to Test and Validate Startup Ideas: – The Startu...",
            text: "One of the first steps to launching a successful startup is building your Minimal Viable Product. In essence, a Minimal Viable Product (MVP) is all about verifying the fact that there is a market…",
            link: "https://medium.com/swlh/how-to-start-a-startup-e4f002ff3ee1",
            tags: ["#link", "#article", "#medium", "#read_later", "#validating", "#validating_idea"]
        ),
        (
            type: "link",
            label: "The best Slack groups for UX designers – UX Collect...",
            text: "Tons of companies are using Slack to organize and facilitate how their employees communicate on a daily basis. Slack has now more than 5 million daily active users and more than 60,000 teams around…",
            link: "https://uxdesign.cc/the-best-slack-groups-for-ux-designers-25c621673d9c",
            tags: ["#link", "#article", "#medium", "#read_later", "#ux", "#community"]
        )
    ]
    
    var filteredCards: [(type: String, label: String?, text: String, link: String?, tags: [String])] = []
    
    func filterCards() {
        filteredCards = cardsData.filter { cardData in
            var isValidByTags = true
            var isValidByWords = true
            
            if let searchingArray = searchingString?.split(separator: " ") {
                let searchingTags = searchingArray.filter { $0.hasPrefix("#") }
                let searchingWords = searchingArray.filter { !$0.hasPrefix("#") }
                
                searchingTags.forEach { searchingTag in
                    if !isValidByTags { return }
                    
                    var isValidTag = false
    
                    cardData.tags.forEach { tag in
                        if tag.lowercased() == searchingTag.lowercased() {
                            isValidTag = true
                        }
                    }
                    
                    if !isValidTag {
                        isValidByTags = false
                    }
                }
                
                searchingWords.forEach { searchingWord in
                    if !(cardData.label != nil && (cardData.label?.lowercased().contains(searchingWord.lowercased()))!) {
                        isValidByWords = false
                    }
                    
                    if !cardData.text.lowercased().contains(searchingWord.lowercased()) {
                        isValidByWords = false
                    }
                }
                
//                searchingWords.forEach { searchingWord in
//                    if !isValidByWords { return }
//
//                    var isValidWord = false
//
//                    cardData.label?.split(separator: " ").forEach { word in
//                        if word.lowercased() == searchingWord.lowercased() {
//                            isValidWord = true
//                        }
//                    }
//
//                    cardData.text.split(separator: " ").forEach { word in
//                        if word.lowercased() == searchingWord.lowercased() {
//                            isValidWord = true
//                        }
//                    }
//
//                    if !isValidWord {
//                        isValidByWords = false
//                    }
//                }
            }
            
            return isValidByTags && isValidByWords
        }
    }
    
    func configureSearch() {
        search.placeholderString = "Enter one or more tags devided by space and some words. For example, #link #work Design"
        search.textColor = NSColor.textPrimary
        search.isBordered = false
        
        search.wantsLayer = true
        search.layer?.backgroundColor = NSColor.secondary.cgColor
        search.layer?.cornerRadius = 16
        
        search.delegate = self
        
        searchView.addSubview(search)
        
        search.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        search.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        search.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        search.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        view.addSubview(searchView)
        
        searchView.autoSetDimension(.height, toSize: 50)
        searchView.autoPinEdge(toSuperviewEdge: .top)
        searchView.autoPinEdge(toSuperviewEdge: .right)
        searchView.autoPinEdge(.bottom, to: .top, of: cardList)
        searchView.autoPinEdge(toSuperviewEdge: .left)
    }
    
    func configureCardList() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        cardList.collectionViewLayout = flowLayout
        
        cardList.delegate = self
        cardList.dataSource = self
        
        cardList.register(Card.self, forItemWithIdentifier: cardId)
        
        view.addSubview(cardList)
        
        cardList.autoPinEdge(toSuperviewEdge: .right)
        cardList.autoPinEdge(toSuperviewEdge: .bottom)
        cardList.autoPinEdge(toSuperviewEdge: .left)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterCards()
        
        configureCardList()
        configureSearch()
    }
}

extension ViewController: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout, NSTextFieldDelegate {
    func collectionView(_ cardList: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCards.count
    }
    
    func collectionView(_ cardList: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let card = cardList.makeItem(withIdentifier: cardId, for: indexPath) as! Card
        
        card.data = filteredCards[indexPath.item]
        
        return card
    }
    
    func collectionView(_ cardList: NSCollectionView, layout cardListLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: 240, height: 240)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        searchingString = search.stringValue
        
        filterCards()
        
        cardList.reloadData()
    }
}
