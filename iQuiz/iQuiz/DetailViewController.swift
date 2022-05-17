//
//  DetailViewController.swift
//  iQuiz
//
//  Created by Yash Katwal on 5/15/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var category: String?
    var ans = ""
    


    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var b1: UIButton!
    
    @IBOutlet weak var b2: UIButton!
    
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var b4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = ("\(category!) Quiz")
        
        b1.setTitle("1", for: .normal)
        b2.setTitle("2", for: .normal)
        b3.setTitle("3", for: .normal)
        b4.setTitle("4", for: .normal)
        

    }
    
    var lastSelectedButton = UIButton()
    
    
    @IBAction func btnPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        lastSelectedButton.isSelected = false
        lastSelectedButton.setTitleColor(UIColor.clear, for: UIControl.State.normal)
        lastSelectedButton.backgroundColor = UIColor.clear
        lastSelectedButton = button
        button.isSelected = true
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.backgroundColor = UIColor.green
        ans = button.titleLabel!.text!

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let answerViewController = segue.destination as! AnswerViewController

        answerViewController.correct = ans
        answerViewController.category = category!
    }

}
