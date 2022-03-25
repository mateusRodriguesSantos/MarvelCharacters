//
//  CharactersListViewController.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 23/03/22.
//

import UIKit
import SnapKit
import NetworkCore
import RxSwift
import RxCocoa

class CharactersListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = CharactersListViewModel()
    var characterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterTableView = UITableView()
        applyViewCode()
        setUpObservers()
        viewModel.fechCharacters(page: viewModel.pageList)
    }

}

extension CharactersListViewController {
    
    private func setUpObservers() {
        observerData()
        observerInfiniteScroll()
        observerSelection()
    }
    
    private func observerData() {
        viewModel.listCharsRelay.bind(to: characterTableView.rx.items(cellIdentifier: "MyCell", cellType: CharacterCellView.self)) { row, model, cell in
            cell.nameCharacter.text = model.name
        }
        .disposed(by: self.disposeBag)
    }
    
    private func observerInfiniteScroll() {
        characterTableView.rx.willDisplayCell.subscribe(onNext: { [weak self] element in
            self?.viewModel.checkEndList(element.indexPath.row)
        }).disposed(by: self.disposeBag)
    }
    
    private func observerSelection() {
        characterTableView.rx.itemSelected.asObservable().subscribe(onNext: { element in
            PeformNavigation.navigate(event: AppCoordinatorDestinys.details)
        }).disposed(by: self.disposeBag)
    }
    
}

extension CharactersListViewController: ViewCodable  {
    
    func buildHierarchy() {
        self.view.addSubview(characterTableView)
    }
    
    func setupConstraints() {
        characterTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(20)
            make.bottom.equalTo(self.view.snp_bottomMargin)
            make.left.equalTo(self.view.snp_leftMargin)
            make.right.equalTo(self.view.snp_rightMargin)
        }
    }
    
    func configureViews() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.displayTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        characterTableView.contentInsetAdjustmentBehavior = .never
        characterTableView.register(CharacterCellView.self, forCellReuseIdentifier: "MyCell")
    }
}
