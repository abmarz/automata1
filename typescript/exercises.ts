
export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// First then apply function (Completed with the help of Dr. Toal)
export function firstThenApply<T, U>(
  items: T[],
  predicate: (item: T) => boolean,
  consumer: (item: T) => U
): U | undefined {
  for (const item of items) {
    if (predicate(item)) {
      return consumer(item)
    }
  }
  return undefined
}

// Powers generator function (Completed with the help of Dr. Toal)

export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; ; power *= base) {
    yield power
  }
}

// Line count function  (Completed with the help of built-in AI tools)
export function meaningfulLineCount(code: string): number {
  let count = 0
  for (const line of code.split("\n")) {
    if (line.trim() !== "" && !line.startsWith("//")) {
      count++
    }
  }
  return count
}

// Shape type and associated functions (Completed with the help of Dr. Toal)
interface Sphere {
  kind: "Sphere"
  radius: number
}

interface Box {
  kind: "Box"
  width: number
  length: number
  depth: number
}

export type Shape = Sphere | Box

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return 4 * Math.PI * shape.radius ** 2
    case "Box":
      return 2 * (shape.width * shape.length + shape.length * shape.depth + shape.depth * shape.width)
  }
}

export function volume(shape: Shape): number { 
  switch (shape.kind) {
    case "Sphere":
      return (4 / 3) * Math.PI * shape.radius ** 3
    case "Box":
      return shape.width * shape.length * shape.depth
  }
}

// Binary Search Tree (Completed with the help of built-in AI tools)
export interface BinarySearchTree<T> {
  size(): number;
  insert(value: T): BinarySearchTree<T>;
  contains(value: T): boolean;
  inorder(): T[];
  toString(): string;
}

export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0;
  }

  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty(), new Empty());
  }

  contains(value: T): boolean {
    return false;
  }

  inorder(): T[] {
    return [];
  }

  toString(): string {
    return "";
  }
}

class Node<T> implements BinarySearchTree<T> {
  value: T;
  left: BinarySearchTree<T>;
  right: BinarySearchTree<T>;

  constructor(value: T, left: BinarySearchTree<T>, right: BinarySearchTree<T>) {
    this.value = value;
    this.left = left;
    this.right = right;
  }

  size(): number {
    return 1 + this.left.size() + this.right.size();
  }

  insert(value: T): BinarySearchTree<T> {
    if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right);
    } else if (value > this.value) {
      return new Node(this.value, this.left, this.right.insert(value));
    } else {
      return this;
    }
  }

  contains(value: T): boolean {
    if (value === this.value) {
      return true;
    } else if (value < this.value) {
      return this.left.contains(value);
    } else {
      return this.right.contains(value);
    }
  }

  inorder(): T[] {
    return [...this.left.inorder(), this.value, ...this.right.inorder()];
  }

  toString(): string {
    const leftString = this.left.toString();
    const rightString = this.right.toString();
    const leftPart = leftString ? leftString : "";
    const rightPart = rightString ? rightString : "";
    return `(${leftPart}${this.value}${rightPart})`;
  }
}
