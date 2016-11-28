//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    
    var countDict: [String: Int] = [:]
    var alphabetDict = [String:Int]()


    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            let textArr = text.lowercased().components(separatedBy: CharacterSet.punctuationCharacters.union(CharacterSet.whitespacesAndNewlines))
            for word in textArr {
                countDict[word] = (countDict[word] ?? 0) + 1
            }
            
            // here's your text
        }
        filterAlphabetically()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return alphabetDict.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = alphabetDict.keys.sorted()[section]
        return alphabetDict[key] ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let key = alphabetDict.keys.sorted()[indexPath.section]
        let word = self.countDict.keys.filter {$0.hasPrefix(key)}.sorted()[indexPath.row]

        cell.textLabel?.text = "\(word): \(self.countDict[word] ?? 0)"
        
        return cell
    }
    
    func filterAlphabetically () {
        let alphabet = "q w e r t y u i o p a s d f g h j k l z x c v b n m".components(separatedBy: " ")
        for letter in alphabet {
            let count = self.countDict.filter {$0.key.hasPrefix(letter)} .count
            print(self.countDict.filter {$0.key.hasPrefix(letter)})
            print(letter, count)
            let check = count > 0
            self.alphabetDict[letter] = check ? count : nil
        }
    }
    
    func filterNumerically () {
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = alphabetDict.keys.sorted()[section]
        return key.uppercased()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
