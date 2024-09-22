from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts

### ANSWERS START HERE ###

# first then lower case function:                          # HWF(**)
def first_then_lower_case(strings, predicate):
    for string in strings:
        if predicate(string):
            return string.lower()
    return None


# powers generator function:
def powers_generator(*, base, limit):
    exponent = 0
    while True:
        power = base ** exponent
        if power > limit:
            break
        yield power
        exponent += 1


# say function:
def say(arg = None):
    words = []
    def func(arg = None):
        if arg is not None:
            words.append(arg)
            return func
        else:
            return ' '.join(words)
    return func if arg is None else func(arg)


# meaningful line count function:
def meaningful_line_count(filename):
    try:
        with open(filename, 'r') as file:
            lines = file.readlines()
            meaningful_lines = [
                line.strip() for line in lines
                if line.strip() and not line.strip().startswith('#')   #removes whitespace + checks for comment 
            ]
            return len(meaningful_lines)
    except FileNotFoundError:
        raise FileNotFoundError(f'File not found: {filename}')


# Quaternion class function:                                                                 #HWF(1.4)
from dataclasses import dataclass

@dataclass(frozen = True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    def __add__(self, other):
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d
        )
    def __multiply__(self, other):                                                          
        return Quaternion(                                                                  #HWF(1.5)
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.d + self.b * other.a,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a)
   
    @property
    def coefficients(self):
        return [self.a, self.b, self.c, self.d]

    def conjugate(self):
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __equality__(self, other):
        return self.a == other.a and self.b == other.b and self.c == other.c and self.d == other.d
    
    def __string__(self):
        return f"{self.a} + {self.b}i + {self.c}j + {self.d}k" 
    
