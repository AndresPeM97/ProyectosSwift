//
//  PlayerManager.swift
//  TFTApi
//
//  Created by Andres Perez Martinez on 28/08/24.
//

import Foundation

let urlPlayerInfo = "https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id"
let apiKey = "api_key=RGAPI-4f871235-1ab8-493f-9e95-b5799294da8b"

let apiURL = "https://la1.api.riotgames.com"

struct PetImageData:Decodable{
    var full: String?
    var sprite:String?
    var group:String?
    var x:Int?
    var y:Int?
    var w:Int?
    var h:Int?
}
struct PetData:Decodable {
    var id:String?
    var tier:String?
    var name:String?
    var image:PetImageData?
}
struct Pets:Decodable {
    var type:String?
    var version:String?
    var data: [String:PetData?]
}
struct ChampionsData:Decodable {
    var id:String?
    var tier:Int?
    var name:String?
    var image:PetImageData?
}
struct Champions:Decodable {
    var type:String?
    var version:String?
    var data: [String:ChampionsData?]
}

struct CompanionInfo:Decodable {
    var content_ID: String?
    var item_ID: Int?
    var skin_ID: Int?
    var species: String?
}
struct TraitsInfo:Decodable {
    var name:String?
    var num_units:Int?
    var style:Int?
    var tier_current:Int?
    var tier_total:Int?
}
struct UnitsInfo:Decodable {
    var character_id:String?
    var itemNames: [String?]
    var name:String?
    var rarity:Int?
    var tier:Int?
}
struct MissionInfo:Decodable{
    var PlayerScore2:Int?
}
struct ParticipantsInfo:Decodable {
    var augments:[String?]
    var companion:CompanionInfo?
    var gold_left:Int?
    var last_round:Int?
    var level: Int?
    var missions:MissionInfo?
    var placement:Int?
    var players_eliminated:Int?
    var puuid:String?
    var time_eliminated:Float?
    var total_damage_to_players:Int?
    var traits:[TraitsInfo?]
    var units:[UnitsInfo?]
    
}

struct MetadataInfo:Decodable {
    var data_version: String?
    var match_id:String?
    var participants:[String?]
}
struct MatchInfo:Decodable {
    var endOfGameResult:String?
    var gameCreation: Int?
    var gameId: Int?
    var game_datetime:Int?
    var game_lenght: Float?
    var game_version:String?
    var mapId:Int?
    var participants:[ParticipantsInfo?]
    var queueId:Int?
    var queue_id:Int?
    var tft_game_type:String?
    var tft_set_core_name:String?
    var tft_set_number:Int?
}
struct MatchData:Decodable{
    var metadata:MetadataInfo?
    var info:MatchInfo?
}

struct PlayerInfo:Decodable {
    var puuid:String?
    var gameName:String?
    var tagLine:String?
}

struct SummonerData: Decodable {
    var accountId:String?
    var profileIconId:Int?
    var revisionDate:Int?
    var id:String?
    var puuid:String?
    var summonerLevel: Int?
}

protocol PlayerManagerDelegate {
    func didUpdatePlayer(player: SummonerData)
    func didGetMatchData(matchPlayerInfo: ParticipantsInfo, gameDate:Int)
    func didUpdatedIcon(iconData: Data)
    func didUpdatePet(petData:Data)
    func didUpdateChampion(championData:Data)
}

struct PlayerManager {
    
    let playerURL = urlPlayerInfo
    var delegate: PlayerManagerDelegate?
    
    func fetchPlayer(userName: String, tag: String) {
        let urlString = "\(playerURL)/\(userName)/\(tag)?\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) {data, response, error in
                if let safeData = data {
                    
                    if let player = self.parseJSON(playerInfo: safeData) {
                        fetchSummonerData(playerPuuid: player.puuid!)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(playerInfo:Data) -> PlayerInfo? {
        
        do {
            let decodedData = try JSONDecoder().decode(PlayerInfo.self, from: playerInfo)
            
            let player = PlayerInfo(puuid: decodedData.puuid, gameName: decodedData.gameName, tagLine: decodedData.tagLine)
            return player
        } catch {
            print(error)
            return nil
        }
    }
    
    func fetchSummonerData(playerPuuid: String) {
        print(playerPuuid)
        let urlRequest = "tft/summoner/v1/summoners/by-puuid"
        let urlString = "\(apiURL)/\(urlRequest)/\(playerPuuid)?\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                
                
                if let safeData = data {
                    if let summoner = self.parseSummoner(summoner : safeData) {
                        delegate?.didUpdatePlayer(player: summoner)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseSummoner(summoner: Data) -> SummonerData? {
        
        do {
            let decodedData = try JSONDecoder().decode(SummonerData.self, from: summoner)
            let summonerInfo = decodedData
            return summonerInfo
        } catch {
            print(error)
            return nil
        }
    }
    
    func getIconImage(iconId: Int){
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.17.1/img/profileicon/\(iconId).png")
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url!) { data, response, error in
            if let safeData = data {
                delegate?.didUpdatedIcon(iconData: safeData)
            }
        }
        task.resume()
    }
    
    func getMatchHistory(summonerPuuid: String) {
        let urlString = URL(string:"https://americas.api.riotgames.com/tft/match/v1/matches/by-puuid/\(summonerPuuid)/ids?start=0&count=10&\(apiKey)")
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: urlString!) { data, response, error in
            if let safeData = data {
                do {
                    let matchList = try JSONDecoder().decode([String].self, from: safeData)
                    if(matchList.count > 0) {
                        getLastPetNumber(lastMatch: matchList, summonerPuuid: summonerPuuid)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
        
        
    }

    func getLastPetNumber(lastMatch:[String], summonerPuuid:String) {
        
        for (i, match) in lastMatch.enumerated() {
            let urlString = URL(string:"https://americas.api.riotgames.com/tft/match/v1/matches/\(match)?\(apiKey)")
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: urlString!) {data, response, error in
                
                if let safeData = data {
                    do {
                        if let decodedData = try JSONDecoder().decode(MatchData?.self, from: safeData) {
//                            var xd:MatchData
                            let xd = decodedData
                            let index = xd.metadata!.participants.firstIndex {
                                $0 == summonerPuuid
                            }
                            let playerMatchInfo = xd.info!.participants[index!]!
                            
                            if(i == 0) {
                                let imageID = playerMatchInfo.companion!.item_ID!
                                print(imageID)
                                getLastPetData(imageId: imageID)
                                delegate?.didGetMatchData(matchPlayerInfo: playerMatchInfo, gameDate:xd.info!.game_datetime!)
                            } else {
                                delegate?.didGetMatchData(matchPlayerInfo: playerMatchInfo, gameDate:xd.info!.game_datetime!)
                            }
                            
                        }
                        
    //                    print(decodedData.info!.participants.)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
        
    }

    func getLastPetData(imageId:Int) {
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.17.1/data/en_US/tft-tactician.json")
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url!) { data, response, error in
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(Pets.self, from: safeData)
                    let image = (decodedData.data[String(imageId)]!)?.image?.full
                    
                    print(image!)
                    
                    getPetImage(imageName:image!)
                } catch {
                    print(error)
                }

            }
        }
        task.resume()
    }
    
    func getPetImage(imageName:String) {
        
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.17.1/img/tft-tactician/\(imageName)")
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url!) { data, response, error in
            if let safeData = data {
                delegate?.didUpdatePet(petData: safeData)
            }
        }
        task.resume()
        
    }
    
    func getMatchResources(charactersIDs: [String]) {
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.17.1/data/en_US/tft-champion.json")
        let urlSession = URLSession(configuration: .default)
        
        
        let task = urlSession.dataTask(with: url!) { data, response, error in
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(Champions.self, from: safeData)
                    
                    let imageNames = charactersIDs.map {
                        decodedData.data["Maps/Shipping/Map22/Sets/TFTSet12/Shop/\($0)"]!?.image!.full
                    }
                    getChampionsImage(championsImage: imageNames)
                    
                } catch {
                    print(error)
                }

            }
        }
        task.resume()
    }
    
    func getChampionsImage(championsImage:[String?]) {
        
        for image in championsImage {
            let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.17.1/img/tft-champion/\(image!)")
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url!) { data, response, error in
                if let safeData = data {
                    delegate?.didUpdateChampion(championData: safeData)
                }
            }
            task.resume()
        }
    }
}
