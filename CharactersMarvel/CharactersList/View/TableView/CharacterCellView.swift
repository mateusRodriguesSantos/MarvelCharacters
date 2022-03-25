//
//  CharacterCellView.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit
import SnapKit

class CharacterCellView: UITableViewCell {
    
    var nameCharacter: UILabel
    var imageCharacter: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.nameCharacter = UILabel()
        self.imageCharacter = UIImageView()
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterCellView: ViewCodable {
    
    func buildHierarchy() {
        addSubview(nameCharacter)
        addSubview(imageCharacter)
    }
    
    func setupConstraints() {
        nameCharacter.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.6)
            make.left.equalTo(self.contentView.snp_leftMargin)
            make.centerY.equalTo(self.snp.centerY)
        }
        imageCharacter.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(50)
            make.right.equalTo(self.contentView.snp_rightMargin).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func configureViews() {
        nameCharacter.font = UIFont.preferredFont(forTextStyle: .body)
        nameCharacter.textColor = .black
        nameCharacter.textAlignment = .left
    }
    
}
