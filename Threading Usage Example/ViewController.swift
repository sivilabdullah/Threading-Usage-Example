//
//  ViewController.swift
//  Threading Usage Example
//
//  Created by abdullah's Ventura on 6.06.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var data = Data()
    var tracker = 0
    let urls = ["https://crevisio.com/free-high-resolution-wallpapers/Crevisio-0298-Horseshoe-Bend-Panorama-Ultra-High-Resolution.jpg","https://crevisio.com/free-high-resolution-wallpapers/Crevisio-0297-Grand-Canyon-Evening-Ultra-High-Resolution.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urls[self.tracker])!)//background proccess
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)// main proccess
            }
        }
            
       
        
        
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(changePic))
    }
    
    @objc func changePic(){
        if tracker == 0 {
            tracker += 1
        }else{
            tracker -= 1
        }
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urls[self.tracker])!)//background proccess
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)// main proccess
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "threading test"
        cell.contentConfiguration = content
        return cell
    }

}

