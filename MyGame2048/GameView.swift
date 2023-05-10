
import Foundation
import UIKit

class GameView: UIView{
    
    let indentFromX = 30
    let indentFromY = 50
    let headerHeight = 150
    let size: Int = 4
    var table = [[UILabel]]()
    let viewController: ViewController
    let colors: [Int: UIColor] = [
        0: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0),
        2: UIColor(red: 238/255, green: 228/255, blue: 218/255, alpha: 1.0),
        4: UIColor(red: 237/255, green: 224/255, blue: 200/255, alpha: 1.0),
        8: UIColor(red: 242/255, green: 177/255, blue: 121/255, alpha: 1.0),
        16: UIColor(red: 245/255, green: 149/255, blue: 99/255, alpha: 1.0),
        32: UIColor(red: 246/255, green: 124/255, blue: 95/255, alpha: 1.0),
        64: UIColor(red: 246/255, green: 94/255, blue: 59/255, alpha: 1.0),
        128: UIColor(red: 237/255, green: 207/255, blue: 114/255, alpha: 1.0),
        256: UIColor(red: 237/255, green: 204/255, blue: 97/255, alpha: 1.0),
        512: UIColor(red: 237/255, green: 200/255, blue: 80/255, alpha: 1.0),
        1024: UIColor(red: 237/255, green: 197/255, blue: 63/255, alpha: 1.0),
        2048: UIColor(red: 237/255, green: 194/255, blue: 46/255, alpha: 1.0),
    ]
    
    init(frame: CGRect, viewController: ViewController) {
        self.viewController = viewController
        super.init(frame: frame)
        createStackView()
        initializeCells()
        backgroundColor = UIColor(red: 231 / 255, green: 228 / 255, blue: 220 / 255, alpha: 1.0)
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
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 26.0)
        label.textColor = UIColor(red: 207 / 255, green: 142 / 255, blue: 85 / 255, alpha: 1.0)
        return label
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Game 2048"
        label.textColor = UIColor(red: 56 / 255, green: 50 / 255, blue: 48 / 255, alpha: 1.0)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
        return label
    }()
    
    private lazy var restartLabel: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 56 / 255, green: 50 / 255, blue: 48 / 255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 228 / 255, green: 218 / 255, blue: 208 / 255, alpha: 1.0), for: .normal)
        button.setTitle("Restart", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28.0)
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        return button
    }()
    
    @objc func restart(){
        self.removeFromSuperview()
        viewController.restartGame()
    }
    
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
    
    public func setLose(){
        message.text = "Oh no, you lose!"
    }
    
    public func setStart(){
        message.text = ""
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
        addSubview(restartLabel)
        stackView.backgroundColor = UIColor(red: 133 / 255, green: 70 / 255, blue: 65 / 255, alpha: 1.0)
        stackView.layer.cornerRadius = 2 * .pi
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        NSLayoutConstraint.activate([
            
            header.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(indentFromY)),
            header.centerXAnchor.constraint(equalTo: centerXAnchor),
            header.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(indentFromX)),
            header.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            
            message.centerXAnchor.constraint(equalTo: centerXAnchor),
            message.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(indentFromX)),
            message.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30),
            
            stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(-2 * indentFromX)),
            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: restartLabel.topAnchor, constant: -50),
            
            restartLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            restartLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: CGFloat(-2 * indentFromX)),
            restartLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func initializeCells() {
        for x in 0..<size {
            table.append([UILabel]())
            for _ in 0..<size {
                table[x].append(UILabel())
            }
        }
        for x in (0..<size).reversed() {
            let rowStackView = UIStackView()
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.axis = .horizontal
            rowStackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            rowStackView.isLayoutMarginsRelativeArrangement = true
            rowStackView.spacing = 10
            rowStackView.distribution = .fillEqually
            stackView.addArrangedSubview(rowStackView)
            NSLayoutConstraint.activate([
                rowStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
            for y in 0..<size {
                let cell = table[x][y]
                cell.translatesAutoresizingMaskIntoConstraints = false
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
