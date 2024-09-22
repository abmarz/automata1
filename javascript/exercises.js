import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// // // ANSWERS START HERE // // //

// first then lower case function:                             // HWF(**)
export function firstThenLowerCase(strings, predicate) {
  const first = strings.find(predicate)
  return first?.toLowerCase()
}

// powers generator function:
export function * powersGenerator({base, limit}) {
  let exponent = 0;
  while (true) {
    let power = Math.pow(base, exponent);
    if (power > limit) break;
    yield power;
    exponent++;
  }
}

// say function:
export function say(){
  const words = [];
  return function(arg){
    if (arg) {
      words.push(arg);
      return say();
    } else {
      return words.join(' ');
    }
  };
}

// meaningful line count function:                               // HWF(1.3)
const fs = require('fs').promises;                               // Node.js file system module
export async function meaningfulLineCount(filename) {
  try {
    const data = await fs.readFile(filename, 'utf8');            // Decode the file as a UTF-8 string
    const lines = data.split('\n');                              // Split the data into lines
    const meaningfulLines = lines.filter(line => {               // Filter out the lines that are empty or start with a '#'
      const trimmed = line.trim();                               // Remove whitespace
      return trimmed !== '' && !trimmed.startsWith('#');
    });
    return meaningfulLines.length;
  } 
  catch (error) {
    throw new Error('Error reading file: ${error.message}');
  }
}

// Quaternion class function:
// HWF(NA)
