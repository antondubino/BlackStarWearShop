import UIKit

class SizeViewController: UIViewController {

    @IBOutlet weak var sizeTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var basket = BasketViewController()
    var product = Product()
    var arrayInBasket = Persistance.shared.getItems()
    var array2 = [ProductData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setTitle("ОТМЕНА", for: .normal)
        cancelButton.layer.cornerRadius = 20
        view.backgroundColor = UIColor.clear
        self.sizeTableView.delegate = self
        self.sizeTableView.dataSource = self
    }
    
}
extension SizeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.offers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Выберите размер"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeTableViewCell", for: indexPath) as! SizeTableViewCell
        cell.sizeLabel.text = "\(product.offers[indexPath.row].size) RUS"
        cell.quantityLabel.text = "\(product.offers[indexPath.row].quantity) шт"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ProductData()
        item.productOfferID = Int(product.offers[indexPath.row].productOfferID)!
        item.name = product.name
        item.size = product.offers[indexPath.row].size
        item.colorName = product.colorName
        item.quantity = product.offers[indexPath.row].quantity
        item.mainImage = product.mainImage
        item.price = product.price
        Persistance.shared.save(item: item)
        dismiss(animated: true, completion: nil)
    }
}
