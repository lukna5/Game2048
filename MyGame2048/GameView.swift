
import Foundation
import UIKit

class GameView: UIView{
    
    let indentFromX = 30
    let indentFromY = 50
    let headerHeight = 150
    var size: Int = 4
    private var table = [[UILabel]]()
    let colors: [Int: UIColor] = [
        0: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0),
        2: UIColor(red: 238/255, green: 228/255, blue: 218/255, alpha: 1.0), // бежевый
        4: UIColor(red: 237/255, green: 224/255, blue: 200/255, alpha: 1.0), // светло-желтый
        8: UIColor(red: 242/255, green: 177/255, blue: 121/255, alpha: 1.0), // оранжевый
        16: UIColor(red: 245/255, green: 149/255, blue: 99/255, alpha: 1.0), // светло-оранжевый
        32: UIColor(red: 246/255, green: 124/255, blue: 95/255, alpha: 1.0), // коралловый
        64: UIColor(red: 246/255, green: 94/255, blue: 59/255, alpha: 1.0), // красный
        128: UIColor(red: 237/255, green: 207/255, blue: 114/255, alpha: 1.0), // светло-зеленый
        256: UIColor(red: 237/255, green: 204/255, blue: 97/255, alpha: 1.0), // зеленый
        512: UIColor(red: 237/255, green: 200/255, blue: 80/255, alpha: 1.0), // темно-зеленый
        1024: UIColor(red: 237/255, green: 197/255, blue: 63/255, alpha: 1.0), // светло-синий
        2048: UIColor(red: 237/255, green: 194/255, blue: 46/255, alpha: 1.0), // синий
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStackView()
        initializeCells()
        backgroundColor = UIColor(red: 2 / 255, green: 108 / 255, blue: 128 / 255, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private var stackView = UIStackView()
    
    private lazy var message: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Message"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(red: 95 / 255, green: 97 / 255, blue: 63 / 255, alpha: 1.0)
        return label
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Game 2048"
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
        return label
    }()
    
    private func setCell(x: Int, y: Int, val: Int){
        let cell = table[x][y]
        cell.text = String(val)
        if val == 0 {
            cell.text = ""
        }
        cell.backgroundColor = colors[val]
    }
    
    public func setWin(){
        message.text = "Congratulations, you won!!!"
    }
    
    func updateView(gameTable: [[Int]]){
        for x in 0..<size {
            for y in 0..<size {
                setCell(x: x, y: y, val: gameTable[x][y])
            }
        }
    }
    
    func createStackView() {
        addSubview(header)
        addSubview(message)
        stackView.backgroundColor = UIColor(red: 6 / 255, green: 4 / 255, blue: 114 / 255, alpha: 1.0)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        NSLayoutConstraint.activate([
            
            header.topAnchor.constraint(equalTo: topAnchor),
            header.centerXAnchor.constraint(equalTo: centerXAnchor),
            header.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(indentFromX)),
            header.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            message.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50),
            message.centerXAnchor.constraint(equalTo: centerXAnchor),
            message.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(indentFromX)),
            message.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: message.bottomAnchor, constant: CGFloat(indentFromY)),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(-2 * indentFromX)),
            //stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(-2 * indentFromY))
        ])
    }
    
    func initializeCells() {
        for x in 0..<4 {
            table.append([UILabel]())
            for y in 0..<4 {
                table[x].append(UILabel())
            }
        }
        for x in (0..<4).reversed() {
               let rowStackView = UIStackView()
               rowStackView.translatesAutoresizingMaskIntoConstraints = false
               rowStackView.axis = .horizontal
            rowStackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            rowStackView.isLayoutMarginsRelativeArrangement = true            //rowStackView.alignment = .center
               rowStackView.spacing = 10
               rowStackView.distribution = .fillEqually
               stackView.addArrangedSubview(rowStackView)
               NSLayoutConstraint.activate([
                rowStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
               ])
            for y in 0..<4 {
                   let cell = table[x][y]
                   cell.translatesAutoresizingMaskIntoConstraints = false
                   cell.text = String(x * 5 + 7 * y)
                   cell.textAlignment = .center
                   cell.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                   cell.backgroundColor = colors[0]
                   cell.layer.cornerRadius = 4
                   cell.clipsToBounds = true
                   rowStackView.addArrangedSubview(cell)
               }
           }
       }
    
    
}
