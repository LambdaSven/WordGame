open Sqlite3

let database = db_open "data.db" 

let words_table_definition = "CREATE TABLE IF NOT EXISTS words (word TEXT PRIMARY KEY NOT NULL, user INT NOT NULL)"

let create_table database def = match exec database def with 
    | Rc.OK -> print_endline "Initialised"
    | r -> prerr_endline @@ Rc.to_string r; prerr_endline @@ errmsg database

let init = create_table database words_table_definition

let add_word word user = 
    let statement = prepare database "INSERT INTO words VALUES (?, ?)" in
    let _ = bind_text statement 1 word
    and _ = bind_text statement 2 user in
    match step statement with 
    | Rc.DONE -> print_endline @@ "Added Word {" ^ word ^ "} by user {" ^ user ^ "}"; Some word
    | r -> prerr_endline @@ Rc.to_string r; prerr_endline @@ errmsg database; None

let get_words = 
    let statement = prepare database "SELECT word FROM words" in
    let rec stepper results = 
      match step statement with 
        | Rc.ROW -> 
          let row = row_data statement in
          let word = Data.to_string row.(0) in 
            stepper @@ word :: results
        | _ -> results
    in stepper [] |> List.filter Option.is_some |> List.map Option.get 
