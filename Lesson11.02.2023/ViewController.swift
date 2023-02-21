//
//  ViewController.swift
//  Lesson11.02.2023
//
//  Created by Artur on 11.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var ListButton: UIButton!
    
    var filteredProducts: [Product] = []
    var allProducts: [Product] = []
    var FavoriteProducts: [Product] = []
    var searchedProducts: [Product] = []
    
    
    enum Status {

        case fav
        case list
        case cart
    }

    var status: Status = .list

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateProducts()
        regiserCells()
        configDelegates()
    }
    
    private func regiserCells() {
        let myXIB = UINib(nibName: "ProductCell", bundle: .main)
        MyTableView.register(myXIB, forCellReuseIdentifier: "ProductCell")
    }
    
    private func configDelegates() {
        SearchTextField.delegate = self
        MyTableView.delegate = self
        MyTableView.dataSource = self
    }
    
    private func configUI() {
        
        
    }
    
    private func generateProducts() {
        
        allProducts.append(Product(icon: "barbeque", title: "Barbeque", isFavorite: false))
        allProducts.append(Product(icon: "dolma", title: "Dolma", isFavorite: false))
        allProducts.append(Product(icon: "qeabab", title: "Qeabab", isFavorite: false))
        allProducts.append(Product(icon: "xash", title: "Xash", isFavorite: false))
        
        filteredProducts = allProducts
    }
    
    @IBAction func updateListAction(_ sender: UIButton) {
    
    switch sender.tag {
    case 0:
        filteredProducts = allProducts
        status = .list
    case 1:
        filteredProducts = FavoriteProducts
        status = .fav
    default: break
    }
    
    MyTableView.reloadData()
    
}
  
    
    @IBAction func SearchAction(_ sender: UIButton) {
     
        searchedProducts.removeAll()
        if SearchTextField.text != nil {
            for product in allProducts {
                
                if product.title.lowercased().contains(SearchTextField.text!.lowercased()) {
                    searchedProducts.append(product)
                }
                
            }
            filteredProducts = searchedProducts
        }
        MyTableView.reloadData()
    }
    
    
    
}

extension ViewController: UITextFieldDelegate {
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //
    //        return true
    //    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        
    }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            SearchTextField.resignFirstResponder()
            return true
            
        }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell

        cell?.setData(filteredProducts[indexPath.row], index: indexPath.row)
        
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }


}

extension ViewController: ProductCellDelegate {
    func didSelectFavorite(selectedIndex: Int) {
        for i in 0..<(allProducts.count + 1) {
            filteredProducts = allProducts
            if i == selectedIndex {
            if  allProducts[i].isFavorite == true {
                    allProducts[i].isFavorite = false
                FavoriteProducts.removeAll(where: {$0.title == allProducts[i].title})
                } else if allProducts[i].isFavorite == false {
                    allProducts[i].isFavorite = true
                    FavoriteProducts.append(allProducts[i])
                }
                

            }
            

        }
        MyTableView.reloadData()
        filteredProducts = allProducts
        
    }
    
 
}
