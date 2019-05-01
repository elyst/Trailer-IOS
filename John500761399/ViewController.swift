import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var movieObjects: [MovieObject]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trailers"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupRefreshControl()
        setupTableView()
        getData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "TrailerTableViewCell", bundle: nil), forCellReuseIdentifier: "TrailerTableViewCell")
    }
    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func getData() {
        Alamofire.request("https://appstubs.triple-it.nl/trailers/")
            .responseData(completionHandler: { [weak self] (response) in
                guard let jsonData = response.data else { return }
                
                let decoder = JSONDecoder()
                let movieObjectsFromBackend = try? decoder.decode([MovieObject].self, from: jsonData)
                
                self?.movieObjects = movieObjectsFromBackend
            })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerTableViewCell", for: indexPath) as! TrailerTableViewCell
        cell.item = movieObjects?[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let trailerDetailVc = storyboard.instantiateViewController(withIdentifier:
            "TrailerDetailViewController")
        self.navigationController?.pushViewController(trailerDetailVc, animated: true)
    }
}


