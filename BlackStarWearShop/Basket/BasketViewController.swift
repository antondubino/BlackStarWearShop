import UIKit

class BasketViewController: UIViewController {
    
    var arrayProductInBasket = Persistance.shared.getItems(){
        didSet{
            basketTableView.reloadData()
        }
    }

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    @IBAction func busketButtonAction(_ sender: Any) {
    }
    
    var itemID = 0
    var products: [Product] = []
    var product = Product()
    var productIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.basketButton.setTitle("Оформить заказ", for: .normal)
        self.basketButton.layer.cornerRadius = 16
        summLabel.text = "Итого:"
        sumProducts()
        self.basketTableView.dataSource = self
        self.basketTableView.delegate = self
        DispatchQueue.main.async {
            self.basketTableView.reloadData()
        }
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Потяни для обновления")
        refresher.addTarget(self, action: #selector(BasketViewController.refresh), for: UIControl.Event.valueChanged)
        self.basketTableView.addSubview(refresher)
        refresh()
        self.basketTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sumProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProductsLoader().loadProducts(id: itemID) { products in
            self.products = products
            self.basketTableView.reloadData()
        }
    }
    
    var refresher: UIRefreshControl!
    @objc func refresh(){
        self.sumProducts()
        self.refresher.endRefreshing()
    }
    
    func sumProducts(){
        var sum = 0
        for item in arrayProductInBasket{
            sum += Int(Double(item.price) ?? 0) * item.count
        }
        self.costLabel.text = "\(sum) ₽"
        self.basketTableView.reloadData()
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProductInBasket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "ProductCell") as! BasketTableViewCell
        cell.productImageView.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 4).isActive = true
        let item = self.arrayProductInBasket[indexPath.row]
        cell.initCell(item: item)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.arrayProductInBasket[indexPath.row]
        if editingStyle == .delete {
            if item.count > 1{
                Persistance.shared.remove(item: item)
            } else {
                Persistance.shared.removeAl(item: item)
                basketTableView.deleteRows(at: [indexPath], with: .left)
            }
            basketTableView.reloadData()
            sumProducts()
        }
    }
}
