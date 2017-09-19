import Foundation

enum Mark: String {
    case E = "E"
    case X = "X"
    case O = "O"
    
    var opposite: Mark? {
        switch self {
        case .E:
            return nil
            
        case .X:
            return .O
            
        case .O:
            return .X
            
        }
    }
    
    static func ==(lhs: Mark, rhs: Mark) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

struct Board {
    static let Width: Int = 3
    static let Height: Int = 3
    
    internal var data:[Mark] = Array<Mark>(repeating: .E, count: Board.Width * Board.Height)
    
    subscript(row: Int, col: Int) -> Mark {
        get {
            return self.data[row * Board.Width + col]
        }
        
        set {
            self.data[row * Board.Width + col] = newValue
        }
    }
    
    typealias Coordinates = (row: Int, col: Int)
    
    mutating func play(mark: Mark, at coords: Coordinates) {
        self[coords.row, coords.col] = mark
    }
}

extension Board: CustomStringConvertible {
    
    public var description: String {
        var s: String = "\n"
        
        for row in 0..<Board.Height {
            let col0 = self[row, 0].rawValue
            let col1 = self[row, 1].rawValue
            let col2 = self[row, 2].rawValue
            
            s.append(" \(col0) | \(col1) | \(col2)\n")
            
            if row < 2 {
                s.append("────┼───┼────\n")
            }
        }
        
        return s
    }
    
    typealias Move = (coordinate: Coordinates, board: Board)
    
    func expand(for mark: Mark) -> [Move] {
        var possible = [Move]()
        
        for row in 0..<Board.Height {
            for col in 0..<Board.Width {
                if self[row, col] != .E { continue }
                
                let coords = (row: row, col: col)
                var board = self
                
                board.play(mark: mark, at: coords)
                possible.append((coords, board))
            }
        }
        return possible
    }
    
}

