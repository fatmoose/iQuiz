//
//  ViewController.swift
//  iQuiz
//
//  Created by Yash Katwal on 5/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func alert() {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
               //Cancel Action
           }))
           
           self.present(alert, animated: true, completion: nil)
       }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        alert()
    }

    @IBOutlet var tableView: UITableView!
    let arr = ["Mathematics",
                "Marvel Superheros",
                "Science"]
    let imgs = [UIImage(named: "math"), UIImage(named: "marvel"), UIImage(named: "science")]
    let sub = ["This quiz will tes your math abilityf", "Prove your superhero knowledge", "SCIENCE QUIZ!?! SCIENCE QUIZ!"]

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}
extension ViewController: UITableViewDataSource {
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

