open Tyxml.Html

let title = title (txt "Stephen's Super Cool Word Game")

let word_input id = input 
  ~a:[
    a_input_type `Text;
    a_name "word_input";
    Unsafe.string_attrib "hx-post" ("/" ^ id ^ "/add_word");
    Unsafe.string_attrib "hx-target" "#word-list";
    Unsafe.string_attrib "hx-trigger" "keyup[key=='Enter']";
    Unsafe.string_attrib "hx-swap" "beforeend";
  ] ()

let word_list words = List.map (
  fun e -> p ~a:[a_class ["word"]] [txt e]
) words

let word_container words = div
  ~a:[a_id "word-list"; Unsafe.string_attrib "hx-swap" "beforeend"]
  (word_list words)

let head = head title [script ~a:[a_src "https://unpkg.com/htmx.org@2.0.4"] (txt "")] 

  
let body id = body [(word_container DbHandler.get_words); word_input id]

let page id = html head @@ body id
