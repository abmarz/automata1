import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Predicate;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // First then lower case function (help from built-in AI tools)
    public static  Optional <String> firstThenLowerCase(List<String> strings, Predicate <String> predicate) {
        return strings.stream()
            .filter(predicate)
            .findFirst()
            .map(String::toLowerCase);
    }

    // Say function (help from Homework Helper 2)
    static record Sayer(String phrase) {
        Sayer and(String word) {
            return new Sayer(phrase +' '+ word);
        }
    }
    static Sayer say() {
        return new Sayer("");
    }
    static Sayer say(String word) {
        return new Sayer(word);
    }

    // Line count function (help from Dr. Toal in office)
    static long meaningfulLineCount(String filename) throws IOException {
        try (var reader = new BufferedReader(new FileReader(filename))) {
             return reader.lines()
                .map(String::trim)
                .filter(line -> !line.isBlank() && !line.startsWith("#"))
                .count();
        }
    }
    
}

// Quaternion record class (help from Homework Helper 2)
record Quaternion(double a, double b, double c, double d) {

    public final static Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public final static Quaternion I = new Quaternion(0, 1, 0, 0);
    public final static Quaternion J = new Quaternion(0, 0, 1, 0);
    public final static Quaternion K = new Quaternion(0, 0, 0, 1);

   Quaternion plus(Quaternion other) {
        return new Quaternion(a + other.a, b + other.b, c + other.c, d + other.d);
    }

    Quaternion times(Quaternion other){
        return new Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a);
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }

    @Override

    public String toString() {
        var sb = new StringBuilder();
        if (a != 0) sb.append(a);
        if (b != 0) sb.append(b > 0 ? "+" + b + "i" : b + "i");
        if (c != 0) sb.append(c > 0 ? "+" + c + "j" : c + "j");
        if (d != 0) sb.append(d > 0 ? "+" + d + "k" : d + "k");
        return sb.toString();
    }
}


// BinarySearchTree sealed interface and its implementations (from Homework Helper 2)
sealed interface BinarySearchTree permits Empty, Node {
    int size();
    BinarySearchTree insert(String data);
    boolean contains(String data);
}

final record Empty() implements BinarySearchTree {
    @Override public int size() {
        return 0;
    }

    @Override public BinarySearchTree insert(String data) {
        return new Node(data, this, this);
    }

    @Override public boolean contains(String data) {
        return false;
    }

    @Override public String toString() {
        return "()";
    }
}

final record Node (
        String data, BinarySearchTree left, BinarySearchTree right)
        implements BinarySearchTree {
    @Override public int size() {
        return left.size() + right.size() + 1;
    }

    @Override public BinarySearchTree insert(String data) {
        if (data.compareTo(this.data) < 0) {
            return new Node(this.data, left.insert(data), right);
        } else if (data.compareTo(this.data) > 0) {
            return new Node(this.data, left, right.insert(data));
        } else {
            return this;
        }
    }

    @Override public boolean contains(String data) {
        if (data.compareTo(this.data) < 0) {
            return left.contains(data);
        } else if (data.compareTo(this.data) > 0) {
            return right.contains(data);
        } else {
            return true;
        }
    }

    @Override public String toString() {
        return ("(" + left + data + right + ")").replace("()", "");
    }
}