//
//  NoticeBoardVC.swift
//  StudentAdmission
//
//  Created by Akshay Jangir on 13/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class NoticeBoardVC: UIViewController {
	
    private var noticeArray = [Notice]()
    
    private let noticeTable = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeArray = CoreNoticeHandler.shared.fetch()
        noticeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notice"
        view.addSubview(noticeTable)
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNotice))
        navigationItem.setRightBarButton(addItem, animated: true)
        setuptableview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noticeTable.frame = view.bounds
    }
    
    @objc private func addNewNotice()
    {
        let alert = UIAlertController(title: "Add SNotice", message: "Please Write Down The Notice", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "Notice"
        }
        let action = UIAlertAction(title:"Submit", style: .default) { (_) in
            guard let notice = alert.textFields?[0].text
            else{
                return
            }
            CoreNoticeHandler.shared.insert(notice: notice, completion: {
                [weak self] in
                    let vc = NoticeBoardVC()
                    self?.navigationController?.pushViewController(vc, animated: false)
            })
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension NoticeBoardVC: UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noticeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stud", for: indexPath)
        let not = noticeArray[indexPath.row]
        cell.textLabel?.text = "\(not.notice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let alert = UIAlertController(title: "Update Notice", message: "Please Update The Notice", preferredStyle: .alert)
        let not = noticeArray[indexPath.row]

        alert.addTextField { (tf) in
            tf.text = "\(String(not.notice))"
        }
        let action = UIAlertAction(title:"Submit", style: .default) { (_) in
            guard let notice = alert.textFields?[0].text
            else{
                return
            }
            
            CoreNoticeHandler.shared.update(not:not , notice: notice, completion: {
                [weak self] in
                    print(notice)
                    print(div)
                    let vc = NoticeBoardVC()
                    self?.navigationController?.pushViewController(vc, animated: false)
            })
        }
        alert.addAction(action)

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setuptableview()
    {
        noticeTable.register(UITableViewCell.self, forCellReuseIdentifier: "stud")
        noticeTable.delegate = self
        noticeTable.dataSource = self
    }
}
