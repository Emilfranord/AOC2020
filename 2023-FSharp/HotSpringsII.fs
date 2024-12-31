module AOC.HotSpringsII

open Xunit
open FsUnit.Xunit

type node = 
    | Operational of node
    | Damaged of node
    | Unknown of node * node
    | Terminal

type verification =
    | Verified
    | Indeterminate
    | Not

(* Read the nodes as a tree, and constantly check if it could be the numerical input *)

let solveStageOne (scanner : Kattio.Scanner) : unit =
    failwith "TEMPLATE"
    ()


let solveStageTwo (scanner : Kattio.Scanner) : unit =
    failwith "TEMPLATE"
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0
