let dict_eng = Words.words "lib/words_alpha.txt"

let validate_word word length dictionary =
  match dictionary with
    | "English" ->
      let lower = String.lowercase_ascii word and
      x = Str.regexp "^[a-z]+$" in
      Str.string_match x lower 0 && 
      String.length word >= length &&
      Option.is_some @@ Hashtbl.find_opt dict_eng lower
    | _ -> false
