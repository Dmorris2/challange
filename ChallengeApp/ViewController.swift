//
//  ViewController.swift
//  ChallengeApp
//
//  Created by Daven Morris on 1/25/22.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var result: [GuideSection] = []
   
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UINib(nibName: "GuideTableViewCell", bundle: nil), forCellReuseIdentifier: "GuideCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        view.addSubview(tableView)//Milestone 3
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result[section].date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = result[indexPath.section].data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as? GuideTableViewCell else {
            fatalError()
        }
        cell.setModel(model)
        
        return cell
    }
    
    //JSON
    func getJsonData(){
        
        if let jsonURL = URL(string: "https://www.guidebook.com/service/v2/upcomingGuides/"){
            
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: jsonURL) {(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }//Milestone 2
                if let safeData = data , let guide = self.parseJson(guideData: safeData) {
                    var sections = [GuideSection]()
                    for item in guide.data{
                        let dates = sections.map { $0.date }
                        if dates.contains(item.startDate) {
                            var sectionToModify = sections.first(where: { $0.date == item.startDate })
                            sectionToModify?.data.append(item)
                        } else {
                            // Create section
                            //Milestone 4
                            let section = GuideSection(date: item.startDate, data: [item])
                            sections.append(section)
                        }
                    }
                    DispatchQueue.main.async {
                        self.result = sections
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(guideData: Data) -> Guide?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Guide.self, from: guideData)
            print(decodedData) //Milestone 1
            return decodedData
        } catch{
            print(error)
            return nil
        }
    }
}
