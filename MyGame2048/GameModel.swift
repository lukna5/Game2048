
import Foundation

enum Result {
    case win
    case lose
    case play
    case undo
    
}
class GameModel {
    let size: Int
    public var table: [[Int]]
    
    init(size: Int = 4) {
        self.size = size
        table = Array(repeating: Array(repeating: 0, count: size), count: size)
        randomFill()
    }
    
    // return true if game ends
    public func makeTurn(dir: Direction) -> Result{
        let prevTable = table.map { $0.map { $0 } }
        mergeTiles(dir: dir)
        if checkTableIsSimular(prevTable: prevTable) {
            return .undo
        }
        randomFill()
        let res = checkEndGame()
        return res
    }
    
    func checkTableIsSimular(prevTable: [[Int]]) -> Bool{
        for y in 0..<size {
            for x in 0..<size {
                if table[y][x] != prevTable[y][x]{
                    return false
                }
            }
        }
        return true
    }
    
    func mergeTiles(dir: Direction){
        print(6)
        switch dir {
        case .up, .right:
            for y in (0..<4).reversed() {
                for x in (0..<4).reversed() {
                    let cell = table[y][x]
                    
                    if dir == .up  {
                        var y1 = y - 1
                        while y1 != -1 && table[y1][x] == 0 {
                            y1 -= 1
                        }
                        
                        if y1 >= 0 && table[y1][x] == cell {
                            if cell == 0 {
                                table[y][x] = table[y1][x]
                            } else {
                                table[y][x] = 2 * cell
                            }
                            table[y1][x] = 0
                        }
                        let val = table[y][x]
                        table[y][x] = 0

                        for i in( 0..<size).reversed() {
                            if table[i][x] == 0 {
                                table[i][x] = val
                                break
                            }
                        }
                    } else if dir == .right {
                        var x1 = x - 1
                        while x1 != -1 && table[y][x1] == 0 {
                            x1 -= 1
                        }
                        if x1 >= 0 && table[y][x1] == cell {
                            if cell == 0 {
                                table[y][x] = table[y][x1]
                            } else {
                                table[y][x] = 2 * cell
                            }
                            table[y][x1] = 0
                        }

                        let val = table[y][x]
                        table[y][x] = 0

                        for i in (0..<size).reversed() {
                            if table[y][i] == 0 {
                                table[y][i] = val
                                break
                            }
                        }
                    }
                }
            }
        case .bottom, .left:
            for y in 0..<size {

                for x in 0..<size {

                    let cell = table[y][x]

                    if dir == .bottom {

                        var y1 = y + 1
                        while y1 != size && table[y1][x] == 0 {
                            y1 += 1
                        }

                        if y1 < size && table[y1][x] == cell {
                            if cell == 0 {
                                table[y][x] = table[y1][x]
                            } else {
                                table[y][x] = 2 * cell
                            }
                            table[y1][x] = 0
                        }
                        
                        let val = table[y][x]
                        table[y][x] = 0
                        for i in 0..<size {
                            if table[i][x] == 0 {
                                table[i][x] = val
                                break
                            }
                        }
                    } else if dir == .left {
                        var x1 = x + 1
                        while x1 != size && table[y][x1] == 0 {
                            x1 += 1
                        }

                        if x1 < size && table[y][x1] == cell {
                            table[y][x] = 2 * cell
                            table[y][x1] = 0
                        }
                        
                        let val = table[y][x]
                        table[y][x] = 0
                        for i in 0..<size {
                            if table[y][i] == 0 {
                                table[y][i] = val
                                break
                            }
                        }

                    }
                }
            }
        }
    }
    
    func randomFill() {
        var zeroCells = [(Int, Int)]()
        for i in 0..<size {
            for j in 0..<size {
                if table[i][j] == 0 {
                    zeroCells.append((i, j))
                }
            }
        }
        
        guard zeroCells.count > 0 else {
            return
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(zeroCells.count)))
        let random10 = Int(arc4random_uniform(UInt32(10)))
        let randomNum = random10 == 0 ? 4 : 2
        let (row, col) = zeroCells[randomIndex]
        table[row][col] = randomNum
    }

    func checkEndGame() -> Result {
        if size < 2 {
            return .lose
        }
        
        var containsZero = false
        for a in table {
            for cell in a {
                if cell == 32 {
                    return .win
                }
                containsZero = containsZero || cell == 0
            }
        }
        
        if containsZero {
            return .play
        }
        
        for x in 0..<size - 1 {
            for y in 0..<size-1{
                let cell = table[x][y]
                if cell == table[x + 1][y] || cell == table[x][y + 1] {
                    return .play
                }
            }
        }
        let last = table[size - 1][size - 1]
        
        if last == table[size - 1][size - 2] || last == table[size - 2][size - 1] {
            return .play
        }
        return .lose
    }
    
    func hasEmptyTile() -> Bool {
        for row in table {
            if row.contains(0) {
                return true
            }
        }
        return false
    }
}
