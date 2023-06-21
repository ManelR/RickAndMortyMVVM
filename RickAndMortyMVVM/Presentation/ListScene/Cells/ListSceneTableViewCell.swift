//
//  ListSceneTableViewCell.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import UIKit
import Combine

class ListSceneTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSecondary: UILabel!
    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var viewOverlay: UIView!

    private let viewModel: ListSceneTableViewCellModelType = DIRepository.shared.resolve()
    private var subscriptions: Set<AnyCancellable> = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bind()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func bind() {
        subscriptions = [
            self.viewModel.titleText.assign(to: \.text, on: self.lblTitle),
            self.viewModel.secondaryText.assign(to: \.text, on: self.lblSecondary),
            self.viewModel.showAlive.sink {
                guard let show = $0 else { return }
                self.configAlive(show: show)
            },
            self.viewModel.imageData.sink { self.configImage(data: $0) }
        ]
    }

    func configView(from character: CharacterDomain) {
        self.viewModel.configView(from: character)
    }

    private func configImage(data: Data?) {
        if let data = data {
            self.imgAvatar?.image = UIImage(data: data)
        } else {
            self.imgAvatar.image = nil
        }
    }

    private func configAlive(show: Bool) {
        self.viewOverlay.isHidden = show
        if show {
            self.lblTitle.textColor = .label
        } else {
            self.lblTitle.textColor = .red
        }
    }
}
