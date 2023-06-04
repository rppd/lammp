open Lammp

let version = "0.01" ;;

let usage () =
  let _ =
    Printf.eprintf
      "Usage: %s [file]\n\tRead an Imp program from file (default is stdin) and compile it to bytecode\n%!"
    Sys.argv.(0) in
  exit 1
;;

let main () =
  let input_channel =
    match Array.length Sys.argv with
    | 1 -> stdin
    | 2 -> (
        match Sys.argv.(1) with
        | "-" -> stdin
        | name -> (
            try open_in name with
              _ -> Printf.eprintf "Opening %s failed\n%!" name; exit 1
           )
       )
    | _n -> usage () in
  let lexbuf = Lexing.from_channel input_channel in
  let _ = Printf.printf "        Welcome to Lämp, version %s\n%!" version in
  try
    let _ = Printf.printf  "> %!" in
    let prgm = Parse.program Lex.lex lexbuf in
    let _ = Ast.print_program stdout prgm in
    let _ = Printf.fprintf stdout " :\n%!" in
    Printf.printf  "Bye.\n%!" ; exit 0
  with
  | Lex.Eoi -> Printf.printf "Unexpected en of file.\n%!" ; exit 1
  | Failure msg -> Printf.printf "Error: %s\n%!" msg ; exit 2
  | Parsing.Parse_error ->
    let sp = Lexing.lexeme_start_p lexbuf in
    let ep = Lexing.lexeme_end_p lexbuf in
    Format.printf
      "File %S, line %i, characters %i-%i: Syntax error.\n"
      sp.Lexing.pos_fname
      sp.Lexing.pos_lnum
      (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
      (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
  | Lex.LexError (sp, ep) ->
      Printf.printf
        "File %S, line %i, characters %i-%i: Lexical error.\n"
        sp.Lexing.pos_fname
        sp.Lexing.pos_lnum
        (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
        (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
;;

if !Sys.interactive then () else main () ;;
