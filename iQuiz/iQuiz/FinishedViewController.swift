//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Yash Katwal on 5/16/22.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var count: Int?
    
    @IBOutlet weak var final: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBAction func customBack(_ sender: Any) {
       _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(count == 0) {
            final.text = "Better luck next time :("
        } else {
            final.text = "You're so smart!"
        }
        
        score.text = ("Your score is \(count!)/1")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
