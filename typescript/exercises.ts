import { open } from "node:fs/promises"

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

// Write your first then apply function here HWF**
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

// Write your powers generator here HWF**
export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; ; power *= base) {
    yield power
  }
}

// Write your line count function here  **Translate from java

// Write your shape type and associated functions here HWF(1.1)
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

// Write your binary search tree implementation here
// export interface BinarySearchTree<T> {
//   size(): number
//   insert(value: T): BinarySearchTree<T>
//   contains(value: T): boolean
//   inorder(): T[]
// }

// class Empty<T> implements BinarySearchTree<T> {
//   size(): number {
//     return 0
//   }

//   insert(value: T): BinarySearchTree<T> {
//     return new Node(value, new Empty(), new Empty())
//   }

//   contains(value: T): boolean {
//     return false
//   }

//   inorder(): T[] {
//     return []
//   }
// }
