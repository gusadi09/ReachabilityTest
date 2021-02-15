//
//  ViewController.swift
//  ReachabilityTest
//
//  Created by Gus Adi on 15/02/21.
//

import UIKit
import Reachability

class ViewController: UIViewController {
    
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                        self.view.backgroundColor = UIColor.green
                    }
        }
        
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                        self.view.backgroundColor = UIColor.red
                    }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged , object: reachability)
            do{
                try reachability.startNotifier()
            } catch {
                print("Could not strat notifier")
            }
    }

    @objc  func internetChanged(note:Notification)  {
        let reachability  =  note.object as! Reachability
        if reachability.connection != .unavailable{
            if reachability.connection == .wifi{
                self.view.backgroundColor = UIColor.green
            }
            else{
                DispatchQueue.main.async {
                    self.view.backgroundColor = UIColor.orange
                }
            }
        } else{
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor.red
            }
        }
    }

}

