module AOC.Wait

open Xunit
open FsUnit.Xunit

type Game = int64 * int64


let winsRace (game: Game) (holdTime:int64) = 
    let totalTime, distance = game
    let travelDist = (totalTime - holdTime) * holdTime 
    distance < travelDist

let enumerateRaces (game:Game) =
    let (time,_) = game
    [0L .. time]
    |> List.map (fun x -> winsRace game x)
    |> List.filter (fun x -> x=true)
    |> List.length
    |> int64

let solveStageOne (scanner : Kattio.Scanner) : unit =
    let _ = scanner.Next ()
    let a = scanner.NextLong ()
    let b = scanner.NextLong ()
    let c = scanner.NextLong ()
    let d = scanner.NextLong ()

    let _ = scanner.Next ()
    let e = scanner.NextLong ()
    let f = scanner.NextLong ()
    let g = scanner.NextLong ()
    let h = scanner.NextLong ()

    [(a,e);(b,f);(c,g);(d,h)] 
    |> List.map enumerateRaces
    |> List.fold (fun state item -> state*item) 1L
    |> printf "%A"

    ()


let solveStageTwo (scanner : Kattio.Scanner) : unit =
    let _ = scanner.Next ()
    let a = scanner.NextLong ()

    let _ = scanner.Next ()
    let e = scanner.NextLong ()

    [(a,e)] 
    |> List.map enumerateRaces
    |> printf "%A"

    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0

[<Fact>]
let testWinsRace () = 
    winsRace (7, 9) 2
    |> should equal true


[<Fact>]
let testEnumerate () = 
    enumerateRaces (7, 9) 
    |> should equal 4L
