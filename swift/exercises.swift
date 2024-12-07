import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// First then lower case function (help from Homework  Helper 2)
func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}

// Say function (help from Homework Helper 2)
struct Sayer{
    let phrase: String
    func and(_ word: String) -> Sayer {
        return Sayer(phrase: phrase + " " + word)
    }
}
func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}

// meaningfulLineCount function (help from Homework Helper 2 and built-in AI tools)
func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    var count = 0
    do {
        let url = URL(fileURLWithPath: filename)
        for try await line in url.lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if !trimmed.isEmpty && !trimmed.hasPrefix("#") {
                count += 1
            }
        }
        // AI tool kicks in here
        return.success(count)
    } catch {
        return.failure(error)
    }
}

// Quaternion struct (help from Homework Helper 2)
struct Quaternion: CustomStringConvertible, Equatable {
    let a, b, c, d: Double

    static let ZERO = Quaternion(a: 0, b: 0, c: 0, d: 0)
    static let ONE = Quaternion(a: 1, b: 0, c: 0, d: 0)
    static let I = Quaternion(a: 0, b: 1, c: 0, d: 0)
    static let J = Quaternion(a: 0, b: 0, c: 1, d: 0)
    static let K = Quaternion(a: 0, b: 0, c: 0, d: 1)

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let a = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let b = lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c
        let c = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let d = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: a, b: b, c: c, d: d)
    }

    static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    var description: String{
        return "\(a)" + (b < 0 ? "" : "+") + "\(b)i" + (c < 0 ? "" : "+") + "\(c)j" + (d < 0 ? "" : "+") + "\(d)k"
    }
}

// Binary Search Tree enum (help from built-in AI tools)
enum BinarySearchTree: CustomStringConvertible {
    case empty
    indirect case node(String, BinarySearchTree, BinarySearchTree)

    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return left.size + right.size + 1
        }
    }

    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(value, .empty, .empty):
            return "(\(value))"
        case let .node(value, left, right):
            return "(\(left)\(value)\(right))"
        }
    }

    func contains(_ element: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(value, left, right):
            if element == value {
                return true
            } else if element < value {
                return left.contains(element)
            } else {
                return right.contains(element)
            }
        }
    }

    func insert(_ element: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(element, .empty, .empty)
        case let .node(value, left, right):
            if element < value {
                return .node(value, left.insert(element), right)
            } else {
                return .node(value, left, right.insert(element))
            }
        }
    }
}