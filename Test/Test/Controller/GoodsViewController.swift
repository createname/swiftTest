//
//  GoodsViewController.swift
//  Test
//
//  Created by wzy on 2019/6/14.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

class GoodsViewController: UIViewController {
    let goodsVM = GoodsViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .groupTableViewBackground
        tableView.register(UINib(nibName: "GoodsTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "GoodsTableViewCell")
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "BannerTableViewCell")
        tableView.register(UINib(nibName: "HomeCategoriesTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "HomeCategoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(44+UIApplication.shared.statusBarFrame.size.height)
        }
        
        tableView.mj_header = MSDRefreshHeader(refreshingBlock: {[weak self]in
            
            self?.goodsVM.requestNewData { (error) in
                tableView.mj_header.endRefreshing()
                if error==nil {
                    tableView.reloadData()
                }
            }
        })
        
        tableView.mj_footer = MSDRefreshFooter(refreshingBlock: {
            [weak self]in
            if tableView.mj_header.state == .refreshing {
                tableView.mj_header.endRefreshing()
                return
            }
            self?.goodsVM.requestNextData(complete: { (error) in
                tableView.mj_footer.endRefreshing()
                if error==nil {
                    tableView.reloadData()
                }
            })
        })
        
        tableView.mj_header.beginRefreshing()
    }
    
}

extension GoodsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cellViewModel = self.goodsVM.dataSource[indexPath.row]
//        (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if self.goodsVM.dataSource.count>indexPath.row{
//
//            let cellViewModel = self.goodsVM.dataSource[indexPath.row]
//            return tableView.fd_heightForHeaderFooterView(withIdentifier: cellViewModel.cellReuseIdentifier(), configuration: { (cell) in
//                (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)
//            })
//        }
//        return 0
//    }
}

extension GoodsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodsVM.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = self.goodsVM.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellReuseIdentifier(), for: indexPath)
        (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)
        return cell
    }
}
