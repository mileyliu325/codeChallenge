//
//  LocationViewController.swift
//  codeChallenge
//
//  Created by Simeng Liu on 6/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var locationTableView: UITableView!
    var dataSource : NSMutableArray = NSMutableArray()
    var refreshControl: UIRefreshControl?
    var overlay : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        self.loactionRequest()
        setTable()
        createDropdownFresh()
    }
    // MARK: - Refresh
    func createDropdownFresh() -> Void {
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action:#selector(refresh), for: UIControlEvents.valueChanged)
        self.locationTableView.addSubview(refreshControl!)
        
    }
    @objc func refresh(sender:AnyObject) {
        
        dataSource = NSMutableArray()
        loactionRequest()
        self.refreshControl?.endRefreshing()
        
    }
    
    // MARK: - Request data
    func loactionRequest()  {
        
        let session = URLSession.shared
        let url = URL(string:"https://s3-ap-southeast-2.amazonaws.com/ios-code-test/v2/locations.json")
        
        let request = URLRequest(url: url!)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
            }
            
            
            if error == nil {
                
                let parsedResult: NSArray
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray
                    
                    for result in parsedResult{
                        
                        print("result:\(result)")
                        
                        let resultDictionary = result as! [String:Any]
                        let location = Location.init(json: resultDictionary)
                        self.dataSource.add(location)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.locationTableView.reloadData()
                        self.overlay?.removeFromSuperview()
                    }
                    
                } catch {
                    displayError("Could not parse the data as JSON: '\(data)'")
                    return
                }
                
            } else {
                print(error!)
            }
            
        }
        
        task.resume()
    }
    
    // MARK: - TableView Config & delegate
    
    func setTable() {
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LocationTableViewCell = self.locationTableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationTableViewCell
        
        cell.locationNameLabel.text = (self.dataSource[indexPath.row] as! Location).display_name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedId = (self.dataSource[indexPath.row] as! Location).id
        
        let location = self.dataSource[indexPath.row] as! Location
        
        self.performSegue(withIdentifier: "toLocationDetail", sender: location)
    }
   
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toLocationDetail") {
            let nextView: DetailViewController? = segue.destination as? DetailViewController
            
            nextView?.location = sender as! Location
        }
        
    }
}
