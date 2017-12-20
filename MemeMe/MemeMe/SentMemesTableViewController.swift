//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Timothy Ng on 11/24/17.
//  Copyright © 2017 Timothy Ng. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var memes = [Meme]()
   
    // MARK: - Properties
    @IBOutlet weak var memeTableView: UITableView!
    
    @IBAction func addMeme(_ sender: Any) {
        let memeEditorVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        present(memeEditorVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memeTableView.rowHeight = 90
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        memeTableView.layoutMargins = UIEdgeInsets.zero
        memeTableView.separatorInset = UIEdgeInsets.zero
        
    }
    
    @objc func reloadList() {
        memeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.memedImage?.image = meme.memedImage
        cell.memeText?.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
