//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class OrderJuiceViewController: UIViewController {
    let juiceMaker = JuiceMaker()
    
    @IBOutlet weak var strawberryStock: UILabel!
    @IBOutlet weak var bananaStock: UILabel!
    @IBOutlet weak var pineappleStock: UILabel!
    @IBOutlet weak var kiwiStock: UILabel!
    @IBOutlet weak var mangoStock: UILabel!
    @IBOutlet weak var bananaJuiceButtonTouch: UIButton!
    @IBOutlet weak var strawberryBananaJuiceButtonTouch: UIButton!
    @IBOutlet weak var strawberryJuiceButtonTouch: UIButton!
    @IBOutlet weak var pineaplleJuiceButtonTouch: UIButton!
    @IBOutlet weak var kiwiMangoJuiceButtonTouch: UIButton!
    @IBOutlet weak var kiwiJuiceButtonTouch: UIButton!
    @IBOutlet weak var mangoJuiceButtonTouch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showStockOfFruits()
        // Do any additional setup after loading the view.
    }
    
    private func showStockOfFruits() {
        strawberryStock.text = "\(juiceMaker.fruitStore.getStock(of: .strawberry))"
        bananaStock.text = "\(juiceMaker.fruitStore.getStock(of: .banana))"
        pineappleStock.text = "\(juiceMaker.fruitStore.getStock(of: .pineapple))"
        kiwiStock.text = "\(juiceMaker.fruitStore.getStock(of: .kiwi))"
        mangoStock.text = "\(juiceMaker.fruitStore.getStock(of: .mango))"
    }
    
    @IBAction func touchUpModifyStock(_ sender: UIBarButtonItem) {
        guard let moveIntoModifyStock = self.storyboard?.instantiateViewController(withIdentifier: "storage") else { return }
        self.navigationController?.pushViewController(moveIntoModifyStock, animated: true)
//        self.present(moveIntoModifyStock, animated: true, completion: nil)

    }
    
    @IBAction func touchUpJuiceMenu(_ sender: UIButton) {
        var selectMenu: JuiceMenu?
    
        switch sender {
        case bananaJuiceButtonTouch:
            selectMenu = .bananaJuice
        case strawberryBananaJuiceButtonTouch:
            selectMenu = .strawberryBananaJuice
        case strawberryJuiceButtonTouch:
            selectMenu = .strawberryJuice
        case pineaplleJuiceButtonTouch:
            selectMenu = .pineappleJuice
        case kiwiMangoJuiceButtonTouch:
            selectMenu = .mangoKiwiJuice
        case kiwiJuiceButtonTouch:
            selectMenu = .kiwiJuice
        case mangoJuiceButtonTouch:
            selectMenu = .mangoJuice
        default:
            print("알수없는 버튼입니다.")
        }
        guard let selectMenu = selectMenu else { return }
        do {
            try juiceMaker.makeJuice(of: selectMenu)
                showStockOfFruits()
                showResultOfOrder(selectedJuice: selectMenu , isPossibleToMakeJuice: true)
            } catch ErrorCase.outOfStock {
                showResultOfOrder(selectedJuice: selectMenu, isPossibleToMakeJuice: false)
            } catch {
                let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
                createAlert(title: "알수없는 오류가 발생했습니다.", message: error.localizedDescription, okAction: okAction, cancelAction: nil)
            }
    }
    
    private func showResultOfOrder(selectedJuice: JuiceMenu?, isPossibleToMakeJuice: Bool) {
        if isPossibleToMakeJuice == true {
            guard let selectedJuice = selectedJuice else { return }
            let title = "주문하신 \(selectedJuice.rawValue) 나왔습니다"
            let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
            createAlert(title: title, message: nil, okAction: okAction, cancelAction: nil)
        } else {
            let title = "재료가 모자라요. 재고를 수정할까요?"
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler : { action in
                    guard let moveIntoModifyStock = self.storyboard?.instantiateViewController(withIdentifier: "storage") else { return }
                    self.navigationController?.pushViewController(moveIntoModifyStock, animated: true)})
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler : nil)
            createAlert(title: title, message: nil, okAction: okAction, cancelAction: cancel)
        }
    }
    
    private func createAlert(title: String?, message: String?, okAction: UIAlertAction? , cancelAction: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let okAction = okAction {
            alert.addAction(okAction)
        }
        if let cancelAction = cancelAction {
            alert.addAction(cancelAction)
        }
        present(alert, animated: true, completion: nil)
    }
}
