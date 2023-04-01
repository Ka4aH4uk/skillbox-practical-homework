//
//  ViewController.swift
//  MVP
//
//  Created by Ka4aH on 22.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = .purple
        searchController.searchBar.placeholder = "Поиск в медиатеке"
        searchController.searchBar.tintColor = .green
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отменить"
        searchController.searchBar.searchTextField.backgroundColor = .white
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 82, bottom: 0, right: 16)
        tableView.separatorColor = .darkGray
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .green
        return view
    }()
    
    let cellId = "MyCustomCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension MainViewController {
    private func setupViews() {
        title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .purple
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
//MARK: -- TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.track?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.purple
        cell?.selectedBackgroundView = backgroundView
        cell?.backgroundColor = .black
        
        let track = presenter.track?[indexPath.row]

        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let urlImage = URL(string: (self.presenter.track?[indexPath.row].artworkUrl100)!)
            URLSession.shared.dataTask(with: urlImage!) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell?.poster.image = UIImage(data: data)
                    self.hideLoadingIndicator()
                }
            }.resume()
        }

        cell?.headerLabel.text = track?.trackName
        cell?.descriptionLabel.text = "Artist: \(track?.artistName ?? "-")" + " / " + "Album: \(track?.collectionName ?? "-")"
        return cell ?? UITableViewCell()
    }
}
//MARK: -- TableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = (presenter.track?[indexPath.row])!
        let detailVC = ModuleBuilder.createDetailModule(track: track)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
//MARK: -- SearchBarDelegate 
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.getTracks(searchText: searchBar.text ?? "") { error in
            if error == nil {
                print("Success!")
            }
            self.showLoadingIndicator()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.hideLoadingIndicator()
    }
}

extension MainViewController: MainViewProtocol {
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        view.willRemoveSubview(self.activityIndicator)
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

