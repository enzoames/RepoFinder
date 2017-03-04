//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Enzo Ames on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


protocol SettingsPresentingViewControllerDelegate: class
{
    
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}


class SettingsViewController: UIViewController
{
    weak var delegate: SettingsPresentingViewControllerDelegate?
    
    @IBOutlet weak var starsCountLabel: UILabel!
    
    @IBOutlet weak var sliderCountLabel: UISlider!
    
    var settings: GithubRepoSearchSettings?
    
    var searchString: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if settings != nil
        {
            sliderCountLabel.value = Float((settings?.minStars)!)
        }
        
        var value = sliderCountLabel.value
        value.round(FloatingPointRoundingRule.down)
        starsCountLabel.text = "\(value)"
        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func onSlideSlider(_ sender: Any)
    {
        let value = sliderCountLabel.value.rounded()
        starsCountLabel.text = "\(value)"
    }
  
    
    @IBAction func onTapSave(_ sender: Any)
    {
        print(delegate)
        
        let settings: GithubRepoSearchSettings = GithubRepoSearchSettings(minstars: Int(sliderCountLabel.value), search: searchString)
        print("ON TAP SAVE- SLIDER COUNT:\(sliderCountLabel.value) , SEARCH STRING: \(searchString)")
       
        delegate!.didSaveSettings(settings: settings)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



















