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

    override func viewDidLoad() {
        super.viewDidLoad()

        gameView = GameView(frame: CGRect())
        gameModel = GameModel()
        updateView(.play)
        initializeGestures()
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
            }
            gameView!.updateView(gameTable: gameModel!.table)
        }

        @objc func moveLeft() {
            let result = gameModel!.makeTurn(dir: .left)
            updateView(result)
        }

        @objc func moveRight() {
            let result = gameModel!.makeTurn(dir: .right)
            updateView(result)
        }

        @objc func moveUp() {
            let result = gameModel!.makeTurn(dir: .up)
            updateView(result)
        }

        @objc func moveDown() {
            let result = gameModel!.makeTurn(dir: .bottom)
            updateView(result)
        }

}
