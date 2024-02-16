//
//  ViewController.swift
//  Calculator Mobile Application
//
//  Created by Vusal Islamzada on 13.02.24.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets: Storyboard üzerindeki etkileşimli öğeleri temsil eder
    // UILabel'lar hesaplamaların gösterileceği alanları temsil eder
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    // Hesaplama adımlarını saklamak için bir String değişkeni tanımlanır
    var workings: String = ""
    
    // ViewController yüklendiğinde yapılacak işlemler viewDidLoad() fonksiyonu içine yazılır
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll() // Hesaplamaları temizle
    }
    
    // Tüm hesaplamaları temizleyen bir fonksiyon
    func clearAll(){
        workings = ""
        calculatorWorkings.text = "" // Hesaplamaların gösterildiği alanı temizle
        calculatorResults.text = "" // Sonucu gösterildiği alanı temizle
    }
    
    // "AC" butonuna basıldığında çağrılan fonksiyon, tüm hesaplamaları temizler
    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    // "C" (Clear) butonuna basıldığında çağrılan fonksiyon, en son eklenen karakteri siler
    @IBAction func backTap(_ sender: Any) {
        if !workings.isEmpty {
            workings.removeLast()
            calculatorWorkings.text = workings // Hesaplamaları güncelle
        }
    }
    
    // Hesaplamalara karakter ekleyen fonksiyon
    func addToWorkings(value: String){
        workings = workings + value
        calculatorWorkings.text = workings // Hesaplamaları güncelle
    }
    
    // "%" butonuna basıldığında çağrılan fonksiyon, "%" karakterini hesaplamalara ekler
    @IBAction func percentTap(_ sender: Any) {
        addToWorkings(value: "%")
    }
    
    // "/" (bölme) butonuna basıldığında çağrılan fonksiyon, "/" karakterini hesaplamalara ekler
    @IBAction func divideTap(_ sender: Any) {
        addToWorkings(value: "/")
    }

    // "*" (çarpma) butonuna basıldığında çağrılan fonksiyon, "*" karakterini hesaplamalara ekler
    @IBAction func timesTap(_ sender: Any) {
        addToWorkings(value: "*")
    }

    // "-" (çıkarma) butonuna basıldığında çağrılan fonksiyon, "-" karakterini hesaplamalara ekler
    @IBAction func minusTap(_ sender: Any) {
        addToWorkings(value: "-")
    }

    // "+" (toplama) butonuna basıldığında çağrılan fonksiyon, "+" karakterini hesaplamalara ekler
    @IBAction func plusTap(_ sender: Any) {
        addToWorkings(value: "+")
    }

    // "=" (eşittir) butonuna basıldığında çağrılan fonksiyon, hesaplamaları gerçekleştirir ve sonucu gösterir
    @IBAction func equalTap(_ sender: Any) {
        if validInput() { // Geçerli giriş kontrol edilir
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString // Sonucu göster
        } else {
            // Geçersiz giriş durumunda bir hata mesajı gösterilir
            let alert = UIAlertController(title: "Invalid Input",
                                          message: "Calculator unable to do math based on input",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Geçerli girişi kontrol eden fonksiyon
    func validInput() -> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        // Özel karakterlerin (çarpma, bölme, toplama, çıkarma) konumları belirlenir
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        // Özel karakterlerin doğru yerleşimini kontrol eder
        var previous: Int = -1
        for index in funcCharIndexes {
            if index == 0 {
                return false
            }
            if index == workings.count - 1 {
                return false
            }
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    // Belirli bir karakterin özel karakter olup olmadığını kontrol eden fonksiyon
    func specialCharacter (char: Character) -> Bool {
        if char == "*" {
            return true
        }
        if char == "/" {
            return true
        }
        if char == "+" {
            return true
        }
        return false
    }
    
    // Hesaplama sonucunu biçimlendiren fonksiyon
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    // Sayı butonlarına basıldığında çağrılan fonksiyonlar
    @IBAction func zeroTap(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func pointTap(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func oneTap(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func twoTap(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func threeTap(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func fourTap(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func fiveTap(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func sixTap(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func sevenTap(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func eightTap(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func nineTap(_ sender: Any) {
        addToWorkings(value: "9")
    }
}
