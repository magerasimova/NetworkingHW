//
//  ListViewController.swift
//  NetworkingHW
//
//  Created by Майя Герасимова on 23.11.2020.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    let images = ["1", "2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {

        let url = URL(string: "https://swapi.dev/api/people/")!

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            let response = response as! HTTPURLResponse
            guard let data = data else {
                print("Data Error Occured. Response Status Code: \(response.statusCode)")
                return
            }

            do {

                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any?]
                
                let result = jsonArray["results"] as! [[String: Any?]]
                
                var i = 0

                for object in result {
                    if let name = object["name"] as? String,
                       let height = object["height"] as? String,
                       let mass = object["mass"] as? String,
                       let hair_color = object["hair_color"] as? String,
                       let skin_color = object["skin_color"] as? String,
                       let eye_color = object["eye_color"] as? String,
                       let birth_year = object["birth_year"] as? String,
                       let gender = object["gender"] as? String,
                       let homeworld = object["homeworld"] as? String,
                       let films = object["films"] as? [String],
                       let species = object["species"] as? [String],
                       let vehicles = object["vehicles"] as? [String],
                       let starships = object["starships"] as? [String],
                       let created = object["created"] as? String,
                       let edited = object["edited"] as? String,
                       let url = object["url"] as? String{
                        self.people.append(Person(name: name, height: height,mass: mass, hair_color: hair_color, skin_color: skin_color, eye_color: eye_color,birth_year: birth_year, gender: gender, homeworld: homeworld, films: films, species: species, vehicles: vehicles, sratships: starships, created: created , edited: edited, url: url, imageName: self.images[i%5]))
                        i = i+1
                    }

                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
            catch (let jsonError) {
                print(jsonError)
            }

        }

        task.resume()
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: PeopleCell.identifier, for: indexPath) as! PeopleCell
        
        let peopleItem = people[indexPath.row]
        
        cell.nameLabel.text = peopleItem.name
        cell.birthLabel.text = "Birth year: \(peopleItem.birth_year)"
        cell.genderLabel.text = "Gender: \(peopleItem.gender)"
        cell.peopleImage.image = UIImage(named: peopleItem.imageName)
        
        return cell
    }
}

