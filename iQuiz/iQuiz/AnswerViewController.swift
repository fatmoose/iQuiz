//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Yash Katwal on 5/16/22.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var correct: String?
    var right = "1"
    var count = 0
    var category: String?
    
    @IBAction func customBack(_ sender: Any) {
       _ = self.navigationController?.popToRootViewController(animated: true)
    }

    @IBOutlet weak var ans: UILabel!
    
    @IBOutlet weak var conc: UILabel!
    
    @IBOutlet weak var quest: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if (correct == right) {
            ans.text = "You got the right answer!"
            count = count + 1
        } else {
            ans.text = "You got the wrong answer!, the right answer is \(right)"
        }
        
        conc.text = ("Your score is \(count)")
        quest.text = ("\(category!) Quiz")

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let finishedViewController = segue.destination as! FinishedViewController

        finishedViewController.count = count
    }
    
    
}
