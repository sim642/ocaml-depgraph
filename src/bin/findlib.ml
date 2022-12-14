open Depgraph
open Common

let run (`Type type_) (`Tred_libraries tred_libraries) (`Depends depends) (`Rdepends rdepends) =
  Findlib_graph.g_of_findlib ~tred_libraries ?depends ?rdepends ()
  |> output type_

open Cmdliner

let depends =
  let doc = "Findlib library whose dependencies to include." in
  Arg.(term_map (fun b -> `Depends b) & value & opt (some string) None & info ["d"; "depends"] ~docv:"LIBRARY" ~doc)

let rdepends =
  let doc = "Findlib library whose reverse dependencies to include." in
  Arg.(term_map (fun b -> `Rdepends b) & value & opt (some string) None & info ["rdepends"] ~docv:"LIBRARY" ~doc)

let term =
  Term.(const run $ Common.type_ $ Common.tred_libraries $ depends $ rdepends)

let cmd =
  let doc = Format.sprintf "Generate dependency graph from findlib libraries." in
  Cmd.v (Cmd.info "findlib" ~doc) term
