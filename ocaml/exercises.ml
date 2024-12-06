exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

(* First Then apply function done with Homework Helper 3 *)
let first_then_apply array predicate customer =
  match List.find_opt predicate array with
  | None -> None
  | Some x -> customer x

(* Powers generator done with Homework Helper 3 *)
let powers_generator base =
  let rec generate_from power () =
    Seq.Cons (power, generate_from (power * base))
  in
  generate_from 1

(* Line count function from Dr. Toal in office *)
let meaningful_line_count filename =

  let is_meaningful_line line =
    let trimmed = String.trim line in
    trimmed <> "" && not (String.starts_with ~prefix:"#" trimmed)
  in

  let ic = open_in filename in
  let finally () = close_in ic in

  let rec count_lines count =
    match input_line ic with
    | line ->
      let new_count = if is_meaningful_line line then count + 1 else count in
      count_lines new_count
    | exception End_of_file ->
      count
  in
  Fun.protect ~finally (fun () -> count_lines 0)

(* Shape type and associated functions *)
type shape =
  | Sphere of float
  | Box of float * float * float

let volume s = 
  match s with
  | Sphere r -> Float.pi *. (r ** 3.) *. 4. /. 3.
  | Box (l, w, h) -> l *. w *. h

let surface_area s = (* from Dr. Toal in office *)
  match s with
  | Sphere r -> 4.0 *. Float.pi *. (r ** 2.0)
  | Box (w, l, d) -> 2.0 *. ((w *. l) +. (w *. d) +. (l *. d))


(* Binary search tree implementation done with help from built-in AI tools *)
type 'a binary_search_tree =
  | Empty 
  | Node of 'a binary_search_tree * 'a *  'a binary_search_tree

let rec size tree =
  match tree with
  | Empty -> 0
  | Node (left, _, right) -> 1 + size left + size right

let rec contains value tree =
  match tree with
  | Empty -> false
  | Node (left, v, right) -> 
    if value = v then
      true
    else if value < v then
      contains value left
    else
      contains value right

let rec inorder tree =
  match tree with
  | Empty -> []
  | Node (left, v, right) -> inorder left @ [v] @ inorder right

let insert value tree =
  let rec aux value tree =
    match tree with
    | Empty -> Node (Empty, value, Empty)
    | Node (left, v, right) -> 
      if value = v then
        tree
      else if value < v then
        Node (aux value left, v, right)
      else
        Node (left, v, aux value right)
  in
  aux value tree
