//
//  DetailViewController.swift
//  codeChallenge
//
//  Created by Simeng Liu on 6/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var detail: Detail!
    var location: Location?
    
    var activities:[RecentActivity]!
    var profiles:[Profile]!
    var tasks:[Task]!
    
    @IBOutlet weak var detailTableView: UITableView!
    var id :Int?
    var topRunnerCount = 0
    var activityCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        id = location?.id
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.allowsSelection = false
        
        requestDetailData(id:id!)
      
    }
    // MARK: - Request data
    
    func requestDetailData(id:Int){
       
        let session = URLSession.shared
        let url = URL(string:"\(APIScheme)://\(APIHost)\(APIPath)/location/\(id).json")
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error == nil{
              
                do {
                    let detailDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    self.updateUI(detailDictionary: detailDictionary)
                }
                catch{
                    displayError("\(PARSE_ERROR)\(String(describing: data))'")
                    return
                }
            
            }
            else{
                print(error!)
                
            }
        }
        task.resume()
    }
    
    func updateUI(detailDictionary:[String:Any]){
      
        self.detail = Detail.init(json: detailDictionary)
        self.activities = self.detail?.generateActivites()
        self.profiles = self.detail?.generateProfiles()
        self.tasks = self.detail?.generateTasks()
        self.topRunnerCount = (self.detail?.profiles.count)!
        self.activityCount =  (self.detail?.recent_activities.count)!
        
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
    
    // MARK: - TableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return topRunnerCount
        default:
            return activityCount
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 150
        default:
            return 150
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell") as! MapTableViewCell
            
            let loc = CLLocationCoordinate2DMake(transfer(str: (location?.latitude)!), transfer(str: (location?.longitude)!))
      
            cell.myMKMapView.setCenter(loc, animated: true)
            cell.myMKMapView.isZoomEnabled = true
            let region = MKCoordinateRegion.init(center: loc, span: .init(latitudeDelta: 0.00725, longitudeDelta: 0.00725))
            cell.myMKMapView.setRegion(region, animated: true)
           
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "topRunnerCell") as! RunnerTableViewCell
            
            let runner = self.profiles[indexPath.row]
           
             let pictureURL = URL(string:"\(APIScheme)://\(APIHost)\(APIPath)\(runner.avatar_mini_url)")
            
            let session = URLSession(configuration: .default)
            
            let downloadPicTask = session.dataTask(with: pictureURL!) { (data, response, error) in
              
                if let e = error {
                    print("\(IMAGE_DOWNLOAD_ERROR) \(e)")
                } else {
                  
                    if let res = response as? HTTPURLResponse {
                       
                        print("\(IMAGE_RESPONSE_CODE) \(res.statusCode)")
                        if let imageData = data {
                            
                            let image = UIImage(data: imageData)
                            
                            
                            DispatchQueue.main.async {
                                
                                cell.runnerImageView.image = image
                                cell.runnerImageView.contentMode = .scaleAspectFill
                                
                            }
                            
                        } else {
                            print(IMAGE_ERROR)
                        }
                    } else {
                        print(RESPONSE_ERROR)
                    }
                }
            }
            
            downloadPicTask.resume()
            
            cell.nameLabel.text =  runner.first_name
            cell.desLabel.text = runner.profileDescription
            cell.ratingLabel.text =  "\(runner.rating)"
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as! ActivityTableViewCell
            
            let activity = self.activities[indexPath.row]
            
            let realMessage = activity.message.replacingOccurrences(of: "{taskName}", with: activity.getTaskName()).replacingOccurrences(of: "{profileName}", with: activity.getProfile().name)
            
            cell.actDesLabel.text = realMessage
            
            
            let catPictureURL = URL(string:"https://s3-ap-southeast-2.amazonaws.com/ios-code-test/v2\(activity.getProfile().url)")
            
           
            let session = URLSession(configuration: .default)
            
            let downloadPicTask = session.dataTask(with: catPictureURL!) { (data, response, error) in
                // The download has finished.
                if let e = error {
                    print("\(IMAGE_DOWNLOAD_ERROR) \(e)")
                } else {
                
                    if let res = response as? HTTPURLResponse {
                        print("\(IMAGE_RESPONSE_CODE)\(res.statusCode)")
                        if let imageData = data {
                            
                            let image = UIImage(data: imageData)
                           
                            DispatchQueue.main.async {
                                cell.activityImageView.image = image
                                cell.activityImageView.contentMode = .scaleAspectFill
                 
                            }
                            
                        } else {
                            
                            print(IMAGE_ERROR)
                        }
                    } else {
                        print(RESPONSE_ERROR)
                    }
                }
            }
            
            downloadPicTask.resume()
            cell.actTypeLabel.text = activity.event
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Map"
        case 1:
            return "Top Runners"
        default:
            return "Recent Activity"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 30
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}
