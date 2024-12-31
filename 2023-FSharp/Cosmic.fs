module AOC.Cosmic

open Xunit
open FsUnit.Xunit
open System

type Galaxy = int64 * int64

let upgradeGalaxy galaxy rows cols amount =
    let x, y = galaxy
    let colsAdd = cols |> List.filter (fun num -> num <= x) |> List.length |> int64
    let rowsAdd = rows |> List.filter (fun num -> num <= y) |> List.length |> int64
    (x + colsAdd * (amount - 1L), y + rowsAdd * (amount - 1L))

let expandUniverse amount (universe: list<list<char>>)  : list<Galaxy> =
    let compact =
        universe
        |> List.mapi (fun x lst -> (List.mapi (fun y ch -> if ch = '#' then Some (int64 x,int64 y) else None ) lst))
        |> List.collect id
        |> List.choose id

    let emptyRows =
        compact
        |> List.map fst
        |> Set.ofList
        |> Set.difference ([0L .. (List.length universe |> int64) - 1L]|> Set.ofList)
        |> Set.toList

    let emptyCols =
        compact
        |> List.map snd
        |> Set.ofList
        |> Set.difference ([0L .. (List.length (List.head universe) |> int64) - 1L]|> Set.ofList)
        |> Set.toList
    
    
    List.map (fun gal -> upgradeGalaxy gal emptyCols emptyRows amount) compact

let dist a b =
    let ax, ay = a
    let bx, by = b
    abs(ax - bx) + abs(ay-by)


let solver amount = 
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.toList
    |> List.map (fun x -> x.ToCharArray () |> List.ofArray )
    |> expandUniverse amount
    |> (fun x -> List.allPairs x x |> List.filter (fun (a,b) -> a < b))
    |> List.map (fun (a,b) -> dist a b)
    |> List.sum
    |> printf "%A"

let solveStageOne (_ : Kattio.Scanner) : unit =
    solver 2

let solveStageTwo (_ : Kattio.Scanner) : unit =
    solver 1000000
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0
