import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option
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

  let d =
    data
    |> list.map(fn(items) { items.1 })
    |> to_ints
    |> list.fold(dict.from_list([]), fn(acc, x) {
      dict.upsert(acc, x, fn(z) {
        case z {
          option.Some(v) -> v + 1
          option.None -> 1
        }
      })
    })

  let out =
    data
    |> list.map(fn(items) {
      let assert Ok(i) = int.parse(items.0)

      let count = dict.get(d, i)

      case count {
        Ok(v) -> v * i
        _ -> 0
      }
    })
    |> list.reduce(fn(acc, x) { acc + x })

  io.debug(out)
}
