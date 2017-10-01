//
//  ArticlesViewController.swift
//  ShoppingApp


import UIKit
import RealmSwift
import SVProgressHUD


var articleManager:ArticleManager = ArticleManager()

class ArticlesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var articlesTableView: UITableView!

    @IBOutlet weak var articleSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setArticles()
        articleManager.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        let nib = UINib(nibName:"ArticleCell",bundle:nil)
        articlesTableView.register(nib, forCellReuseIdentifier: "articleCell")
    }
    
    private func setArticles() {
        SVProgressHUD.show()
        fetchArticles()
    }
    
    func fetchArticles() {
        articleManager.fetchArticles()
    }
    func fetchArticlesBySearch(SearchItem:String){
        articleManager.fetchArticlesFromSearch(searchString: SearchItem)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.getArticles().count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for:indexPath) as! ArticleTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ArticleTableViewCell {
            _configureCell(cell: cell, atIndexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    private func _configureCell(cell:ArticleTableViewCell,atIndexPath:IndexPath) {
        let data = articleManager.getArticlesAt(index:atIndexPath.row)
       
        cell.setCell(data: data)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SVProgressHUD.show()
         searchBar.resignFirstResponder()
        var searchString:String
        if (searchBar.text?.containsWhiteSpace())!{
            searchString = (searchBar.text?.replacingOccurrences(of:" ", with: "_"))!
        } else {
            searchString = searchBar.text! 
        }
        
        fetchArticlesBySearch(SearchItem: searchString)
         searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
  
    @IBAction func filterButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name:"Filters", bundle:nil)
        let filterVC = storyBoard.instantiateViewController(withIdentifier: "filterView")
        self.present(filterVC, animated: true, completion: nil)
    }
}

extension ArticlesViewController:ArticleManagerDelegate {

    func onSuccess() {
        SVProgressHUD.dismiss()
        articlesTableView.reloadData()

    }
    
    func onError() {
        SVProgressHUD.dismiss()
        SVProgressHUD.showInfo(withStatus: "There is no data that you looking for")
        
    }
}
