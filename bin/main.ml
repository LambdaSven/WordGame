let _ = WordGame.DbHandler.init
(*
let _ = WordGame.DbHandler.add_word "'DROP TABLE words; --get hacked" "Hackerman"

let _ = WordGame.DbHandler.add_word "eep" "Hackerman"

let _ = WordGame.DbHandler.add_word "oop" "Hackerman"
*)
let print_words words = List.iter (fun e -> print_endline e) words

let words = WordGame.DbHandler.get_words

let () = print_words words

let () = print_endline @@ string_of_bool @@ WordGame.Game.validate_word "Test Word" 3 "English"
let () = print_endline @@ string_of_bool @@ WordGame.Game.validate_word "The" 3 "English"
let () = print_endline @@ string_of_bool @@ WordGame.Game.validate_word "A" 3 "English"
let () = print_endline @@ string_of_bool @@ WordGame.Game.validate_word "Test" 3 "English"
