//
//  addPriseHeuresViewController.swift
//  monPkEtMoi
//
//  Created by macOS on 18/03/2018.
//  Copyright © 2018 CHU-polytech. All rights reserved.
//

import UIKit

class AddPriseHeuresViewController: UITableViewController {

    var heuresPriseCell: [HeurePriseTableViewCell] = [HeurePriseTableViewCell()]
    @IBOutlet weak var removeButton: UIButton!
    
    var posologie: Posologie? = nil
    let posologieDAO = CoreDataDAOFactory.getInstance().getPosologieDAO()

     // MARK: - Supprimer un champ d'heure si il y'en a plus d'un
    @IBAction func removeHeure(_ sender: Any) {
        heuresPriseCell.removeLast()
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: heuresPriseCell.count, section: 0)], with: .automatic)
        tableView.endUpdates()
        if heuresPriseCell.count == 1 {
            removeButton.isHidden = true
            removeButton.isEnabled = false
        }
    }
     // MARK: - Ajouter un champ d'heure
    @IBAction func addHeure(_ sender: Any) {
        heuresPriseCell.append(HeurePriseTableViewCell())
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: heuresPriseCell.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        removeButton.isHidden = false
        removeButton.isEnabled = true
    }
    //MARK: - Sauvegarder la posologie si le formulaire est valide
    //TODO: Vérifier que le formulaire n'est pas vide pour les heures de prises
    @IBAction func savePosologie(_ sender: Any) {
        print("dedans")
        let heures:[NSDate] = heuresPriseCell.map{(cell) in
            return cell.heurePriseTF.getDate()
        }
        self.posologie?.heuresPrise = heures
        do{
            try posologieDAO.save(posologie: self.posologie!)
            DialogBoxHelper.alert(view: self, WithTitle: "Posologie ajoutée", andMessage: "Ajout avec succès", closure: {(action) in
                self.performSegue(withIdentifier: "unwindFromAddHeuresPrise", sender: self)
            })
        } catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heuresPriseCell.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! HeurePriseTableViewCell
        
        cell.heurePriseLabel.text = "Heure de prise"
        heuresPriseCell[indexPath.row] = cell
        return cell
    }
}

