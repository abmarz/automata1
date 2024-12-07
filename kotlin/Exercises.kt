import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

// First then lower case function (help from Homework Helper 2)
fun firstThenLowerCase(strings: List<String>, predicate: (String) -> Boolean): String? {
    return strings.firstOrNull(predicate)?.lowercase()
}

// Say function (help from Homework Helper 2)
data class Say(val phrase: String ) {
    fun and(nextPhrase: String): Say {
        return Say("$phrase $nextPhrase")
    }
}

fun say(phrase: String = ""): Say {
    return Say(phrase)
}

// meaningfulLineCount function (help from Homework Helper 2 and Dr. Toal)
@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    BufferedReader(FileReader(filename)).useLines { lines ->
        return lines.map(String::trim)
            .filter { it.isNotBlank() && !it.startsWith("#") }
            .count()
            .toLong()
    }
}


// Quaternion data class (help from Homework Helper 2 gave up here)
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {

    companion object{
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }

    operator fun times(other: Quaternion): Quaternion{
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a,
        )
    }

    fun coefficients(): List<Double> =  listOf(a, b, c, d)

    fun conjugate(): Quaternion = Quaternion(a, -b, -c, -d)

    override
    fun toString(): String {
        val parts = mutableListOf<String>()
        if (a != 0.0) parts.add(a.toString())
        if (b != 0.0) parts.add(if (b == 1.0) "i" else "${b}i")
        if (c != 0.0) parts.add(if (c == 1.0) "j" else "${c}j")
        if (d != 0.0) parts.add(if (d == 1.0) "k" else "${d}k")
        if (parts.isEmpty()) return "0"
        return parts.joinToString(separator = "+")
    }

}

// Binary Search Tree interface and implementing classes (help from built-in AI tools)
sealed interface BinarySearchTree {
    fun size(): Int
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree
    override fun toString(): String

    object Empty : BinarySearchTree {
        override fun size(): Int = 0
        override fun contains(value: String): Boolean = false
        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)
        override fun toString(): String = "()"
    }

    data class Node(val value: String, val left: BinarySearchTree, val right: BinarySearchTree) : BinarySearchTree {
        override fun size(): Int = 1 + left.size() + right.size()
        override fun contains(value: String): Boolean = when {
            value < this.value -> left.contains(value)
            value > this.value -> right.contains(value)
            else -> true
        }
        override fun insert(value: String): BinarySearchTree = when {
            value < this.value -> Node(this.value, left.insert(value), right)
            value > this.value -> Node(this.value, left, right.insert(value))
            else -> this
        }
        override fun toString(): String = "($left$value$right)"
    }
}
