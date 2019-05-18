//
//  RecommendListCollectionViewCell.swift
//  Test
//
//  Created by wzy on 2019/4/27.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import MJRefresh

class RecommendListCollectionViewCell: UICollectionViewCell, CellBindViewModelProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    var recommendListVM: RecommendListCollectionViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        
//        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: "BannerTableViewCell")
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: .main), forCellReuseIdentifier: "BannerTableViewCell")
        tableView.register(UINib(nibName: "GoodPriceTableViewCell", bundle: .main), forCellReuseIdentifier: "GoodPriceTableViewCell")
        tableView.register(UINib(nibName: "GoodsTableViewCell", bundle: .main), forCellReuseIdentifier: "GoodsTableViewCell")
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: .main), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: .main), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(UINib(nibName: "HomeCategoriesTableViewCell", bundle: .main), forCellReuseIdentifier: "HomeCategoriesTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        replaceRefresh()
    }
    
    //获取数据
    func replaceRefresh() {
        if let mjheader = tableView.mj_header,mjheader.scrollViewOriginalInset.top>0 && mjheader.state == MJRefreshState.idle {
            let oldContenInset = self.tableView.contentInset
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: oldContenInset.left, bottom: oldContenInset.bottom, right: oldContenInset.right)
        }

        tableView.mj_header = MSDRefreshHeader(refreshingBlock: {
            [weak self] in
            if self?.tableView.mj_footer.state == MJRefreshState.refreshing {
                self?.tableView.mj_footer.endRefreshing()
            }
            self?.recommendListVM?.requestNewData(complete: { (error) in
                self?.tableView.mj_header.endRefreshing()
                if error == nil{
                    self?.tableView.reloadData()
                }
            })
        })

        tableView.mj_footer = MSDRefreshFooter(refreshingBlock: {
            [weak self] in
            if self?.tableView.mj_header.state == MJRefreshState.refreshing {
                self?.tableView.mj_header.endRefreshing()
            }
            self?.recommendListVM?.requestNextPageData { (error) in
                self?.tableView.mj_footer.endRefreshing()
                if error == nil {
                    self?.tableView.reloadData()
                }
            }
        })

        if let count = self.recommendListVM?.dataSource.count,count<=0 {
            tableView.mj_header.beginRefreshing()
        }else{
            tableView.reloadData()
        }
    }
    
    func bind(with vm: CellViewModelProtocol) {
        if let vm = vm as? RecommendListCollectionViewCellViewModel {
            self.recommendListVM = vm
            replaceRefresh()
        }
    }

}

extension RecommendListCollectionViewCell: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = self.recommendListVM else {
            return 0;
        }
        return vm.dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = self.recommendListVM else {
            return tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        }
        let cellViewModel = vm.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellReuseIdentifier(), for: indexPath)
        return cell
        
    }
}

extension RecommendListCollectionViewCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let vm = self.recommendListVM, vm.dataSource.count>indexPath.row else {
            return
        }
        let cellViewModel = vm.dataSource[indexPath.row];
        (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let vm = self.recommendListVM, vm.dataSource.count>indexPath.row else {
            return 0
        }
        let cellViewModel = vm.dataSource[indexPath.row];
        return tableView.fd_heightForCell(withIdentifier: cellViewModel.cellReuseIdentifier(), cacheBy: indexPath, configuration: { (cell) in
            (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)

        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
