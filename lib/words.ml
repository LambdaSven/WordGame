let words dict_file = 
  let tbl = Hashtbl.create 400000 in 
  let ic = open_in dict_file in
  let rec into_map filehandle table =
    try 
      let word = input_line filehandle in
      let trimmed = String.trim word in
      Hashtbl.add table trimmed trimmed;
      into_map filehandle table
    with _ -> 
      close_in_noerr filehandle;
      table in
    into_map ic tbl
