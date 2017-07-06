//
//  ViewController.swift
//  Silly Song
//
//  Created by William Oanta on 06/07/2017.
//  Copyright © 2017 William Oanta. All rights reserved.
//

import UIKit

func shortNameForName(name: String) -> String {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let lowercaseName = name.lowercased()
    
    var shortName = ""
    if let rangeOfFirstVowel = lowercaseName.rangeOfCharacter(from: vowels) {
        shortName = lowercaseName.substring(from: rangeOfFirstVowel.lowerBound)
    } else {
        shortName = lowercaseName
    }
    
    return shortName
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTmeplate: String, fullName: String) -> String {
    let shortName = shortNameForName(name: fullName)
    let lyrics = lyricsTmeplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = UITextAutocapitalizationType.words
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text, name != "" else {
            print("name field is nil")
            return
        }

        lyricsView.text = lyricsForName(lyricsTmeplate: bananaFanaTemplate, fullName: name)
        
    }
}

