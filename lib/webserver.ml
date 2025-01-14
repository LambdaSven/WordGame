let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt ()) elt

let () = DbHandler.get_words |> List.iter (fun e -> print_endline e)

let run =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/" (fun _ ->
      Dream.html ("hello world"));
    Dream.get "/:lobby" (fun lobby -> 
      Dream.html @@ elt_to_string @@ Html.page @@ Dream.param lobby "lobby");
    Dream.post "/:lobby/add_word" (fun request -> 
      let%lwt body = Dream.body request in
      let _ = print_endline ("BODY = " ^ body) in
      Dream.respond body)
      (*match DbHandler.add_word (Dream.param params "lobby") (Dream.param params "word") "Test_User" with 
      | Some x -> Dream.respond ~code:200 ("<p>" ^ x ^ "</p>")
      | None -> Dream.respond ~code:500 "Failed")*)
  ]
