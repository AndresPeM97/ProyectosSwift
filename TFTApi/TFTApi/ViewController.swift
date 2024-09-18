//
//  ViewController.swift
//  TFTApi
//
//  Created by Andres Perez Martinez on 28/08/24.
//

import UIKit


struct Partidas {
    var partida:ParticipantsInfo?
    var champions:[UIImage?]
    var fecha:Int?
}
class ViewController: UIViewController, UITextFieldDelegate, PlayerManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var matchHistoryTable: UITableView!
    @IBOutlet weak var topUiView: UIView!
    @IBOutlet weak var playerIconImageView: UIImageView!
    @IBOutlet weak var playerPetImageView: UIImageView!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var gameLevelLabel: UILabel!
    
    var player = PlayerManager()
    var matches = [ParticipantsInfo]()
    
    var partidas = [Partidas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameNameTextField.delegate = self
        player.delegate = self
        matchHistoryTable.delegate = self
        matchHistoryTable.dataSource = self
        
        let uiNib = UINib(nibName: "TableViewCell", bundle: nil)
        matchHistoryTable.register(uiNib, forCellReuseIdentifier: "TableViewCell")
        
        playerIconImageView.layer.cornerRadius = 20
        playerPetImageView.layer.cornerRadius = 20
        
        topUiView.layer.cornerRadius = 20
        
        gameNameTextField.layer.borderColor = UIColor.black.cgColor
        gameNameTextField.layer.borderWidth = 1
        gameNameTextField.layer.cornerRadius = 15
        
        gameLevelLabel.layer.borderColor = UIColor.black.cgColor
        gameLevelLabel.layer.borderWidth = 1
        gameLevelLabel.layer.cornerRadius = 15
        gameLevelLabel.textColor = .black
        
        let playerIconSaved = UserDefaults.standard.data(forKey: "playerIconData")
        let petIconSaved = UserDefaults.standard.data(forKey: "petIconData")
        let playerNameSaved = UserDefaults.standard.string(forKey: "playerName")
        
        if(playerIconSaved != nil && petIconSaved != nil && playerNameSaved != nil)
        {
            playerIconImageView.image = UIImage(data: playerIconSaved!)
            playerPetImageView.image = UIImage(data: petIconSaved!)
            gameNameTextField.text = playerNameSaved!
            gameLevelLabel.text = UserDefaults.standard.string(forKey: "playerLevel")
            player.fetchPlayer(userName: playerNameSaved!, tag: "Lan")
        }
        matchHistoryTable.reloadData()
    }
    /* Funciones relacionadas con table view*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchHistoryTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let danio = partidas[indexPath.row].partida!.total_damage_to_players!
        let lugar = partidas[indexPath.row].partida!.placement!
        
        cell.cellDamageLabel.text = String("Daño: \(danio)")
        cell.cellPlacementLabel.text = String("Lugar: \(lugar)")
        cell.cellChampion0Image.image = self.partidas[0].champions[0]
        
        print(matches.count)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Presionaste una celda")
    }
    /* Aqui terminan las funciones relacionadas con el tableview */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let nombre = gameNameTextField.text {
            player.fetchPlayer(userName: nombre, tag: "Lan")
            UserDefaults.standard.set(nombre, forKey: "playerName")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gameNameTextField.endEditing(true)
        return true
    }
    
    func didUpdatePlayer(player: SummonerData) {
        DispatchQueue.main.async {
            //            self.gameNameTextField.text = player.puuid
            self.player.getIconImage(iconId: player.profileIconId!)
            self.player.getMatchHistory(summonerPuuid: player.puuid!)
        
            UserDefaults.standard.set(player.summonerLevel, forKey: "playerLevel")
        }
    }
    func didGetMatchData(matchPlayerInfo: ParticipantsInfo, gameDate: Int) {
        let partida = Partidas(partida: matchPlayerInfo, champions: [nil], fecha: gameDate)
        DispatchQueue.main.async {
            self.matches.append(matchPlayerInfo)
            self.partidas.append(partida)
            
            self.partidas.sort{
                $0.fecha! > $1.fecha!
            }
            
            let unidades = partida.partida!.units.map{
                $0!.character_id!
            }
            print(unidades)
            
            self.player.getMatchResources(charactersIDs: unidades)

        }
    }
    func didUpdatedIcon(iconData:Data) {
        DispatchQueue.main.async {
            if let imagen = UIImage(data: iconData) {
                self.playerIconImageView.image = imagen
                UserDefaults.standard.set(iconData, forKey: "playerIconData")
                print(iconData)
            }

        }
    }
    func didUpdatePet(petData:Data) {
        DispatchQueue.main.async {
            if let imagen = UIImage(data: petData) {
                self.playerPetImageView.image = imagen
//                UserDefaults.standard.set("Valor a guardar", forKey: "miClave")
                UserDefaults.standard.set(petData, forKey: "petIconData")
            }
        }
    }
    
    func didUpdateChampion(championData: Data) {
        DispatchQueue.main.async {
            if let imagen = UIImage(data: championData) {
                
                self.partidas[0].champions[0] = imagen
            }
            self.matchHistoryTable.reloadData()
        }
    }
}

