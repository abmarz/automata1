function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

------ ANSWERS START HERE ------

-- first then lower case function:
function first_then_lower_case(array, predicate)
  for i, v in pairs(array) do
    if predicate(v) then
      return string.lower(v)
    end
  end
  return nil
end


-- powers generator function: -- HWF(**)
function powers_generator(base, limit)
  local power = 0
  return coroutine.create(function()
    while power <= limit do
      coroutine.yield(base ^ power)
      power = power + 1
    end
  end)
end


-- say function:      -- HWF(**)
function say(word)
  if word == nil then
    return ""
  end
  return function(next_word)
    if next_word == nil then
      return word
    else
      return say(word .. " " .. next_word)
    end
  end
end


-- meaningful line count function:
function meaningful_line_count(filename)
  local file, err = io.open(filename, "r")
  if not file then
    error("error opening file: " .. err)
  end
  local count = 0
  for line in file:lines() do
    local trimmed = line:match("^%s*(.-)%s*$")           --HWF(1.1)
    if trimmed ~= "" and not trimmed:match("^#") then    --HWF(1.2)
      count = count + 1
    end
  end
  file:close()
  return count
end


-- Quaternion table function:
Quaternion = {} 
function Quaternion.new(a, b, c, d)
  return setmetatable({a = a, b = b, c = c, d = d}, Quaternion)
end

---- Addition function:
function Quaternion.__add(q1, q2)
  return Quaternion.new(q1.a + q2.a,
                        q1.b + q2.b, 
                        q1.c + q2.c, 
                        q1.d + q2.d)
end

---- Multiplication function:
function Quaternion.__mul(q1, q2)
  return Quaternion.new(q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
                        q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
                        q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.a,
                        q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a)
end

---- Coefficient function:
function Quaternion.coefficients(q)
  return {q.a, q.b, q.c, q.d}
end 

---- Conjugate function:
function Quaternion.conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

---- Equality function:
function Quaternion.__eq(q1, q2)
  return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

---- String function:
function Quaternion.__tostring(q)
  return string.format("%g + %gi + %gj + %gk", q.a, q.b, q.c, q.d)
end
