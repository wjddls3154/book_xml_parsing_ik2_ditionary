//
//  ViewController.swift
//  book_xml_parsing_ik2
//
//  Created by k on 헤이세이 30. 10. 7..
//  Copyright © 헤이세이 30년 jik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    
    // 딕셔너리의 배열 저장 : item
    var item:[[String:String]] = []
    // 딕셔너리 : item [key:value]
    var items:[String:String] = [:]
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.dataSource = self
        
        if let path = Bundle.main.url(forResource: "book", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                if myParser.parse() {
                    print("파싱 성공")
                    
                    print("elements = \(items)")
                    
                } else {
                    print("파싱 오류")
                }
            } else {
                print("파싱 에러")
            }
        } else {
            print("XML 파일 없음")
        }
    }
    
    // XMLParser Delegete 메소드
    
    // tag(element)를 만나면 실행
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //print(elementName)
        
        
    }
    
    // tag 다음에 문자열을 만나면 실행
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // 공백제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        // 공백체크 후 데이터 뽑기
        if !data.isEmpty {
            items[currentElement] = data
            //print(item[currentElement])
        }
        
    }
    
    // tag가 끝날때 실행
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            item.append(items)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        let item1 = item[indexPath.row]
        
        cell.textLabel?.text = item1["title"]
        cell.detailTextLabel?.text = item1["author"]
        
        return cell
    }
    
    
}
