module AOC.Wasteland

open Xunit
open FsUnit.Xunit
open System;
open System.Text.RegularExpressions;

type node = string * (string * string)
type direction = Right | Left

let parseDirection =
    function 
    | 'R' -> Right
    | 'L' -> Left
    | _ -> failwith "not a direction"

let parseLine (s:string) : node =
    Regex.Matches(s, @"[A-Z]+") 
    |> Seq.map (fun x ->  x.Value)
    |> (fun x -> (Seq.item 0 x, (Seq.item 1 x, Seq.item 2 x )))

let walkStep all (direction:direction) (current:string) :string =
    let next = Map.find current all
    match direction with
    | Left -> fst next
    | Right -> snd next

let solveStageOne (_ : Kattio.Scanner) : unit =
    let directions = Console.ReadLine() |> Seq.map parseDirection |> Seq.replicate 1000 |> Seq.concat |> List.ofSeq

    Console.ReadLine() |> ignore

    let mapping = 
        Seq.initInfinite (fun _ -> Console.ReadLine())
            |> Seq.takeWhile (fun line -> line <> null)
            |> Seq.map parseLine
            |> Map.ofSeq

    let rec aux current dirs accumulator =
        match current with
        | "ZZZ" -> accumulator
        | x -> aux (walkStep mapping (List.head dirs) x ) (List.tail dirs) (accumulator + 1)
    
    aux "AAA" directions 0
    |> printf "%A"

    ()

let solveStageTwo (scanner : Kattio.Scanner) : unit =
    failwith "TEMPLATE"
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0
