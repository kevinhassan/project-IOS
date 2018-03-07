//
//  CommencerViewController.swift
//  monPkEtMoi
//
//  Created by Yves-Alain AGBODJOGBE on 05/03/2018.
//  Copyright © 2018 CHU-polytech. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CommencerViewController: UIViewController, UITableViewDelegate{
    
    var patients : [Patient] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.alerteError(errorMsg : "Could not save person", userinfo: "Unknow reason")
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        // creer une requête associée à l'entité patient
        let request : NSFetchRequest<Patient> = Patient.fetchRequest()
        
        do{
            try self.patients = context.fetch(request)
        }catch let error as NSError{
            self.alerteError(errorMsg: "\(error)", userinfo: "\(error.userInfo)")
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func alerteError(errorMsg error : String, userinfo user : String = "") {
        let alert = UIAlertController(title: error,
                                      message: user,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)

        
        alert.addAction(cancelAction)
        present(alert,animated: true)

    }

}
