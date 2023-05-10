import UIKit

enum Direction {
    case up
    case bottom
    case left
    case right
}

class ViewController: UIViewController {
    
    var gameModel: GameModel?
    var gameView: GameView?
    var gameIsRun = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartGame()
        initializeGestures()
        view.backgroundColor = UIColor(red: 231 / 255, green: 228 / 255, blue: 220 / 255, alpha: 1.0)
    }
    
    func restartGame() {
        gameView = GameView(frame: CGRect(), viewController: self)
        gameModel = GameModel()
        updateView(.play)
        gameIsRun = true
        view.addSubview(gameView!)
        gameView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameView!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            gameView!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            gameView!.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            gameView!.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
    }
    
    // Do any additional setup after loading the view.
    // Создание 16 UILabel
    func initializeGestures() {
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveLeft))
        leftGesture.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(leftGesture)
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveRight))
        rightGesture.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(rightGesture)
        
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveUp))
        upGesture.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(upGesture)
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveDown))
        downGesture.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(downGesture)
    }
    
    func updateView(_ resultGame: Result) {
        if resultGame == .win {
            gameView!.setWin()
            gameIsRun = false
        }
        if resultGame == .lose {
            gameView!.setLose()
            gameIsRun = false
        }
        gameView!.updateView(gameTable: gameModel!.table)
    }
    
    @objc func moveLeft() {
        if gameIsRun {
            let result = gameModel!.makeTurn(dir: .left)
            updateView(result)
        }
    }
    
    @objc func moveRight() {
        if gameIsRun {
            let result = gameModel!.makeTurn(dir: .right)
            updateView(result)
        }
    }
    
    @objc func moveUp() {
        if gameIsRun {
            let result = gameModel!.makeTurn(dir: .up)
            updateView(result)
        }
    }
    
    @objc func moveDown() {
        if gameIsRun {
            let result = gameModel!.makeTurn(dir: .bottom)
            updateView(result)
        }
    }
    
    
}
