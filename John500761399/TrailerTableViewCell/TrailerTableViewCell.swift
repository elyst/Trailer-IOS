
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
            if (item?.posterImage) != nil {
                movieImage.kf.setImage(with: item?.posterImage)
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
