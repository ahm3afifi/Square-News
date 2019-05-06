//
//  NewsHeadlinesTableViewController.swift
//  thewallnews
//
//  Created by Ahmed Afifi on 4/22/19.
//  Copyright © 2019 Ahmed Afifi. All rights reserved.
//

import Foundation
import UIKit

class NewsHeadlinesTableViewController: UITableViewController {
    
    
    private var categoryListVM: CategoryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateHeadlinesAndArticles()
    }
    
    private func setupUI() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.tableHeaderView = UIView.viewForTableViewHeader(subtitle: Date.dateAsStringForTableViewHeader())
    }
    
    private func populateHeadlinesAndArticles() {
        
        CategoryService().getAllHeadlinesForAllCategories { [weak self] categories in
            self?.categoryListVM = CategoryListViewModel(categories: categories)
            self?.tableView.reloadData()
        }
}
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.categoryListVM.heightForHeaderInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let name = self.categoryListVM.categoryAtIndex(index: section).name
        return UIView.viewForSectionHeader(title: name)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryListVM == nil ? 0 : self.categoryListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListVM.numberOfRowsInSections(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeadlineTableViewCell", for: indexPath) as? NewsHeadlineTableViewCell else {
            fatalError("NewsHeadlineTableViewCell not found")
        }
        
        let articleVM = self.categoryListVM.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
        
        cell.configure(vm: articleVM)
        
        return cell
        
    }
    
   


}
