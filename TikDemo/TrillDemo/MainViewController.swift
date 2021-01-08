//
//  MainViewController.swift
//  TrillDemo
//
//  Created by magic-devel on 2020/10/9.
//

import UIKit
import NVActivityIndicatorView


class MainViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var awemeLists = [AwemeList]()
    
    var vodeoJsonIndex = 12
    var currentPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            }else {
                self.automaticallyAdjustsScrollViewInsets = false
            }
        
        activityIndicatorView.startAnimating()
        getList()
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
}

extension MainViewController {
    func getList() {
        let url = URL(string: TrillURL.baseLocal + vodeoJsonIndex.description + TrillURL.feedFile)!
        getAwemeList(url: url)
        
    }
    
    func getAwemeList(url: URL) {
        do {
            let feed = try Feed(fromURL: url)
            
            if let awemeList = feed.awemeList {
                    self.awemeLists += awemeList
                    activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
        } catch  {
            debugPrint("解析错误",error)
        }
    }
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return awemeLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.aweme = awemeLists[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController: UIScrollViewDelegate{
    // 拖动结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        currentPage = (tableView.indexPathsForVisibleRows?.last!.row)!
        print("页码", currentPage)
        vodeoJsonIndex -= 1
        getList()
    }
}
