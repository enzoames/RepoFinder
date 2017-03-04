//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingsPresentingViewControllerDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings(minstars: 0, search: nil)

    
    var repos: [GithubRepo]!
    
    var startsNumber: Int?
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Perform the first search when the view controller first loads
        doSearch()
        //self.tableView.reloadData()
        
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            
//            for repo in newRepos {
//                print(repo)
//            }   
            
            self.repos = newRepos
            
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print("Error: \(error?.localizedDescription)")
        })
    }
    
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        self.searchSettings = settings
        print("BACK TO REPO RESULTS VIEW CONTROLLER WITH SETTINGS: \(settings)")
        if(settings.searchString != nil) {
            doSearch()
        } else {
            print("settings string nil")
        }
    }
    
    func didCancelSettings() {
        //Nothing. Don't save what the user did over there.
    }
    
    //|||||||||||||||||||||||||||||||||||||||||
    //||||||||||TABLEVIEW METHODS||||||||||||||
    //|||||||||||||||||||||||||||||||||||||||||
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if repos != nil
        {
            return repos.count
        }
        else
        {
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReposCell", for: indexPath) as! ReposCell
        
        cell.repo = repos![indexPath.row]

        return cell
        
    }
    
    //|||||||||||||||||||||||||||||||||||||||||
    //||||||||||PUSH FOR SEGUE|||||||||||||||||
    //|||||||||||||||||||||||||||||||||||||||||
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! SettingsViewController
        
        //Passing the previous search information to the SettingsViewController
        vc.settings = self.searchSettings //.searchSettings refers to GithubRepoSearchSettings
        
        print(vc.settings?.minStars)
        vc.searchString = searchBar.text
        print("PREPARE FOR SEGUE. STRING BEING PASSED: \(vc.searchString)")
        vc.delegate = self

    }
    
    
    
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}










