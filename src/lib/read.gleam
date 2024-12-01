import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub type Error {
  ReadError
  NoLineSeparatorError
}

pub fn parse_spaces2(
  data: String,
  n: Int,
) -> Result(List(#(String, String)), Error) {
  let delim = string.repeat(" ", n)

  let arr = string.split(data, "\n")

  let parsed =
    arr
    |> list.map(fn(ln) {
      let assert Ok(res) = string.split_once(ln, delim)
      res
    })

  Ok(parsed)
}
