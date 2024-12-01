import gleam/int
import gleam/io
import gleam/list
import lib/read
import simplifile

const example = "3   4
4   3
2   5
1   3
3   9
3   3"

fn to_ints(lst: List(String)) -> List(Int) {
  lst
  |> list.map(fn(item) {
    let assert Ok(out) = int.parse(item)
    out
  })
}

pub fn main() {
  let assert Ok(file_data) = simplifile.read("./data/day1")
  let assert Ok(data) = read.parse_spaces2(file_data, 3)

  let left =
    data
    |> list.map(fn(items) { items.0 })
    |> to_ints
    |> list.sort(int.compare)

  let right =
    data |> list.map(fn(items) { items.1 }) |> to_ints |> list.sort(int.compare)

  let out =
    list.zip(left, right)
    |> list.map(fn(items) { int.absolute_value(items.0 - items.1) })
    |> list.reduce(fn(acc, x) { acc + x })

  io.debug(out)
}
