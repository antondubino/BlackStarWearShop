import Foundation

struct Group {
    var name: String
}

class Menu {
    
    var groups = [Group]()
    
    init() {
        setup()
    }
    
    func setup() {
        let g1 = Group(name: "Заказы")
        let g2 = Group(name: "Страна")
        let g3 = Group(name: "Подарочные сертификаты")
        let g4 = Group(name: "Управление подписками")
        
        self.groups = [g1, g2, g3, g4]
    }
}
