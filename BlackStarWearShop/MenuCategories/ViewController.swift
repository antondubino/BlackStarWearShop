import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    var categoryId: [String] = []
    var subcategories: [Subcategory] = []
    var subCategoryId = 0
    var selectedIndex = Int()
    var filterCategories: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.tableView.register(UINib(nibName: "TableViewCell",bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CategoriesLoader().loadCategories{ categories, categoryId  in
            self.categories = categories
            self.categoryId = categoryId
            if self.subcategories.isEmpty {
            self.subcategories = categories[0].subcategories
            }
            self.filterCategories = categories.filter({ category in
                return !category.subcategories.isEmpty
            })
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.initCell(item: filterCategories[indexPath.row])
        if selectedIndex == indexPath.row{
            cell.nameCategory.font = .boldSystemFont(ofSize: 20)
        } else {
            cell.nameCategory.font = .boldSystemFont(ofSize: 10)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        subcategories = filterCategories[indexPath.row].subcategories //
        selectedIndex = indexPath.row
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.initCell2(item: subcategories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let product = subcategories[indexPath.row]
            let vc = storyboard?.instantiateViewController(identifier: "Products") as! ViewControllerProducts
            vc.itemID = product.id
            self.present(vc, animated: true, completion: nil)
            self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
