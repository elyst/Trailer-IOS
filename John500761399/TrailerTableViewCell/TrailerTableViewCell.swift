
import UIKit
import Kingfisher

final class TrailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieText: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var item: MovieObject? {
        didSet {
            movieLabel.text = item?.title
            movieLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            movieText.text = item?.description
            if let imageURLString = item?.posterImage {
                let url = URL(string: imageURLString)
                movieImage.kf.setImage(with: url!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
