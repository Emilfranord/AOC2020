module AOC.Lens

open Xunit
open FsUnit.Xunit
open System


type Instruction =
    | Remove of string
    | Add of string * int

type Lens = string * int


let rec hash (str:list<char>) (cur:int) =
    match str with
    | [] -> cur
    | head::tail -> 
        head 
        |> int 
        |> (+) cur 
        |> ( * ) 17 
        |> (fun x -> x % 256) 
        |> hash tail


let readAndParse () = 
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.toList
    |> String.concat ""
    |> (fun x -> x.Split ',')
    |> List.ofArray

let solveStageOne (scanner : Kattio.Scanner) : unit =
    readAndParse () 
    |> List.map (fun x -> hash ( x |> Seq.toList ) 0)
    |> List.sum
    |> printfn "%A"
    ()

let solveStageTwo (scanner : Kattio.Scanner) : unit =
    failwith "TEMPLATE"
    ()

[<Fact>]
let testSingleHash () = 
    hash ['H'] 0 |> should equal 200
    hash ("HASH"|> Seq.toList ) 0 |> should equal 52
    hash ("rn=1"|>Seq.toList) 0 |> should equal 30
    hash ("cm-"|>Seq.toList) 0 |> should equal 253
