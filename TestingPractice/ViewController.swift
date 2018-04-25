//
//  ViewController.swift
//  TestingPractice
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.dataSource = self
        loadData()
    }
    
    private func loadData() {
        MovieAPI.manager.searchMovies(keyword: "comedy") {[weak self] (error, data) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let movieSearch = try  JSONDecoder().decode(ResultsWrapper.self, from: data)
                    self!.movies = movieSearch.results
                    self!.movieTableView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        cell.configureCell(withMovie: movie)
        
        return cell
    }
}

