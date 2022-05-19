//
//  ViewController.swift
//  iQuiz
//
//  Created by Yash Katwal on 5/10/22.
//

import UIKit
import Foundation
import SystemConfiguration

struct Quiz: Decodable {
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Decodable {
    let question: String
    let answer: String
    let answers: [String]
}


class ViewController: UIViewController {
    var GlobalURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let indexPath = tableView.indexPathForSelectedRow
        // Get the Row of the Index Path and set as index
        let category = arr[indexPath!.row]
        // Get in touch with the DetailViewController
        let detailViewController = segue.destination as! DetailViewController
        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
        detailViewController.category = category
    }
    
    let refreshControl = UIRefreshControl()



    @objc func refresh(_ sender: AnyObject) {
       getJson(url: GlobalURL)
        print("worked")
    }
    
    @IBAction func alert(_ sender: UIBarButtonItem) {
              //Variable to store alertTextField
                var textField = UITextField()
                
                let alert = UIAlertController(title: "Settings", message: "Check for new quiz data?", preferredStyle: .alert)
                alert.addTextField { alertTextField in
                    alertTextField.placeholder = "Enter URL"
                    
                    textField = alertTextField
                }
                alert.addAction(UIAlertAction(title: "Go Back", style: UIAlertAction.Style.default, handler: { _ in

                }))
        
        alert.addAction(UIAlertAction(title: "Check URL", style: UIAlertAction.Style.default, handler: { _ in
            self.GlobalURL = textField.text!
            self.getJson(url: textField.text!)
        }))
            present(alert, animated: true, completion: nil)
            }

    
    
    func getJson(url: String) {
        if (self.isInternetAvailable()) {
        let urlAddress = url
        let url = URL(string: urlAddress)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {
            data, response, error in
            do {
                let JsonData =  try JSONSerialization.jsonObject(with: data!) as! NSArray
                    print (JsonData[0])
            } catch {
                print(error)
            }
            

        }
        task.resume()
        } else {
            showInternetAlert()
        }
        
    }
    
    func isInternetAvailable() -> Bool
      {
          var zeroAddress = sockaddr_in()
          zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
          zeroAddress.sin_family = sa_family_t(AF_INET)

          let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
              $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                  SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
              }
          }

          var flags = SCNetworkReachabilityFlags()
          if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
              return false
          }
          let isReachable = flags.contains(.reachable)
          let needsConnection = flags.contains(.connectionRequired)
          return (isReachable && !needsConnection)
      }
    // From stackoverflow ^

      func showInternetAlert() {
          if !isInternetAvailable() {
              let alert = UIAlertController(title: "Uh oh", message: "Network is Not Available", preferredStyle: .alert)
              let action = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(action)
              present(alert, animated: true, completion: nil)
          }
      }



    @IBOutlet var tableView: UITableView!
    let arr = ["Mathematics",
                "Marvel Superheros",
                "Science"]
    let imgs = [UIImage(named: "math"), UIImage(named: "marvel"), UIImage(named: "science")]
    let sub = ["This quiz will test your math ability", "Prove your superhero knowledge", "SCIENCE QUIZ!?! SCIENCE QUIZ!"]
    
    

}



extension ViewController: UITableViewDataSource, UITableViewDelegate  {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        cell.imageView?.image = imgs[indexPath.row]
        cell.detailTextLabel?.text = sub[indexPath.row]
        return cell
    }

}




