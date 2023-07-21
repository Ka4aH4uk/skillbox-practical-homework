//
//  ViewController.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse: SearchResponse? = nil
    
    private var timer: Timer?

    let cellId = "MyCustomCell"
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.placeholder = "Поиск в медиатеке"
        searchController.searchBar.tintColor = .systemGreen
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отменить"
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.clearButtonMode = .never // grey x

        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 82, bottom: 0, right: 16)
        tableView.separatorColor = .darkGray
        tableView.tableHeaderView = searchController.searchBar
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .purple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 94
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        setupViews()
        showSearchKeyboard(seconds: 1) {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func showSearchKeyboard(seconds: Int, queue: DispatchQueue = DispatchQueue.main, complition: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
}

//MARK: -- UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MyCustomCell
        let film = searchResponse?.results?[indexPath.row]
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.purple
        cell?.selectedBackgroundView = backgroundView
        cell?.backgroundColor = .black
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let urlImage = URL(string: (self.searchResponse!.results![indexPath.row].artworkUrl100))
            URLSession.shared.dataTask(with: urlImage!) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell?.poster.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                    self.view.willRemoveSubview(self.activityIndicator)
                }
            }.resume()
        }
        
        cell?.headerLabel.text = film?.trackName
        cell?.descriptionLabel.text = "Artist: \(film?.artistName ?? "")" + " / " + "Album: \(film?.collectionName ?? "")"

        return cell ?? UITableViewCell()
    }
}

//MARK: -- UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)"

        //Timer
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchFilms(urlString: urlString) { [weak self] (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self?.searchResponse = searchResponse
                self?.tableView.reloadData()
            }
        })
        activityIndicator.startAnimating()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.activityIndicator.stopAnimating()
        self.view.willRemoveSubview(self.activityIndicator)
    }
}

