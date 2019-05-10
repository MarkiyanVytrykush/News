//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Nanter on 5/5/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import UIKit

protocol ArticleTableViewCellDelegate: class {
    func didArticleSelected(with URL: URL)
}

class ArticleTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var imageShowNews: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSourseLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDataLabel: UILabel!

    //MARK: Properties
    
    let viewModel = ArticleTableCellViewModel()

    var article: Article? {
        didSet {
            guard let article = article else { return }
            newsTitleLabel.text = article.title
            newsDescriptionLabel.text = article.description
            newsSourseLabel.text = article.source?.name
            newsDataLabel.text = article.publishedAtDate
            configureViewModel()
            viewModel.setImage(imageUrl: article.stringUrlToImage)
        }
    }

    //MARK: Delegate

    weak var delegate: ArticleTableViewCellDelegate?

    //MARK: Life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        article = nil
        imageShowNews.image = #imageLiteral(resourceName: "placeholder")
    }
    
    //MARK: Configurations
    
    private func configureViewModel() {
        viewModel.didImageGot = { [unowned self] image, imageUrl in
            DispatchQueue.main.async {
                guard imageUrl == self.article?.stringUrlToImage else { return }
                self.imageShowNews.image = image
            }
        }
    }

    //MARK: IBActions
    
    @IBAction func buttonActionSafari() {
        guard let url = article?.url else { return }
        delegate?.didArticleSelected(with: url)
    }
}

