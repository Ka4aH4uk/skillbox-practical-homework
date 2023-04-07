//
//  ViewController.swift
//  MVVM
//
//  Created by Ka4aH on 22.03.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    var viewModel: MainViewModelProtocol! {
        didSet {
            bindViewModel()
        }
    }

    let cellId = "MyCustomCell"

    // MARK: - UIViews
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Private
    private func bindViewModel() {
        viewModel.tracks.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.loading.bind { [weak self] isLoading in
            if isLoading {
                self?.showLoadingIndicator()
            } else {
                self?.hideLoadingIndicator()
            }
        }
    }

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

    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tracks.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomCell
        let track = viewModel.tracks.value[indexPath.row]

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.purple
        cell?.selectedBackgroundView = backgroundView
        cell?.backgroundColor = .black

        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let urlImage = URL(string: (self.viewModel.tracks.value[indexPath.row].artworkUrl100 ?? "")!)
            URLSession.shared.dataTask(with: urlImage!) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell?.poster.image = UIImage(data: data)
                }
            }.resume()
        }

        cell?.headerLabel.text = track.trackName
        cell?.descriptionLabel.text = "Artist: \(track.artistName ?? "-")" + " / " + "Album: \(track.collectionName ?? "-")"
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = viewModel.tracks.value[indexPath.row]
        let detailVC = ModuleBuilder.createDetailModule(track: track)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.searchText.value = searchText
            viewModel.searchTracks()
        }
    }
}
