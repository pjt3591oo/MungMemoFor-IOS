//
//  DetailViewController.swift
//  MungMEmo
//
//  Created by 박정태 on 2019/12/16.
//  Copyright © 2019 JeongTae Park. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memo: Memo?
    @IBOutlet weak var memoTableView: UITableView!
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
   
    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) {[weak self] (action) in
            DataManager.shared.deleteMemo(self?.memo)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        guard let memo = memo?.content else { return }
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
    //해당 화면이 뜨기전에 ComposeViewController의 editTarget속성에 memo를 전달함
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = memo
        }
    }
    
    var token : NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in self?.memoTableView.reloadData()})
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView")
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        default:
            fatalError()
        }
    }
}
