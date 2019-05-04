import UIKit
import Alamofire

var vSpinner : UIView?

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
        title = NSLocalizedString("trailerTitle", comment:"")
        navigationController?.navigationBar.prefersLargeTitles = true
        self.showSpinner(onView: self.view)
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
        let url = NSLocalizedString("urlAPI", comment:"")
        Alamofire.request(url)
            .responseData(completionHandler: { [weak self] (response) in
                guard let jsonData = response.data else { return }
                
                let decoder = JSONDecoder()
                let movieObjectsFromBackend = try? decoder.decode([MovieObject].self, from: jsonData)
                
                self?.movieObjects = movieObjectsFromBackend
                self?.removeSpinner()
            
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
            "TrailerDetailViewController") as! TrailerViewController
        
        trailerDetailVc.movieObject = movieObjects?[indexPath.row]
        self.navigationController?.pushViewController(trailerDetailVc, animated: true)
    }
}

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


