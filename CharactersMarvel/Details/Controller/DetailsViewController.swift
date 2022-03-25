//
//  DetailsViewController.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit
import SnapKit
import NetworkCore
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
    }

    @objc func pressed() {
        PeformNavigation.navigate(event: DetailsCoordinatorDestinys.back)
    }
}

extension DetailsViewController: ViewCodable  {
    
    func buildHierarchy() {
        view.addSubview(backButton)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.width.width.equalTo(50)
            make.centerY.equalTo(self.view.snp.centerY)
            make.left.equalTo(self.view.snp_leftMargin).offset(30)
            make.right.equalTo(self.view.snp_rightMargin).offset(-30)
        }
    }
    
    func configureViews() {
        view.backgroundColor = .white
        let barButtonBackStr = "\u{00D7}"
        let attributes: [NSAttributedString.Key : AnyObject] = [.font : UIFont.systemFont(ofSize: 40)]
        let newBackButton = UIBarButtonItem(title: barButtonBackStr, style: .plain, target: self, action: #selector(pressed))
        newBackButton.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem = newBackButton
    }
}
