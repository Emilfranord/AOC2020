module AOC.CubeConundrum

open Xunit
open FsUnit.Xunit

open System;
open System.Text.RegularExpressions;


type multiset = int * int * int
type game = int * multiset

let isLegalMultiset multi =
    let (r,g,b) = multi
    let rOkay = r <= 12
    let gOkay = g <= 13
    let bOkay = b <= 14

    rOkay && gOkay && bOkay

let parseGame (s:string) : game =
    let segments = s.Split ':'

    if segments.Length < 2 then failwith (sprintf "%A" s ) else ()

    let colors = 
        Regex.Matches(segments[1],  @"\d+ (red|green|blue)")
        |> Seq.map (fun x -> x.Value )
        |> Seq.map (fun x -> x.Split ' ') 
        |> Seq.map (fun x -> (x[1], x[0] |> int))

    let maxFinder sequence k = sequence |> Seq.filter (fun (key, _) ->  key = k) |> Seq.map (fun (_, value) -> value) |> Seq.max

    let red = maxFinder colors "red"
    let green = maxFinder colors "green"
    let blue = maxFinder colors "blue"

    let identity = segments[0].Split ' ' |> (fun x -> x[1] |> int)

    (identity, (red, green, blue))

let handleGame (s:string) = 
    let id, colors = parseGame s
    match isLegalMultiset colors with
    | true -> id 
    | false -> 0

let handleGameII (s:string) =
    let _, colors = parseGame s
    let a,b,c = colors
    a * b * c

let solveStageOne (_ : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.map handleGame
    |> Seq.sum
    |> printfn "%A"
    ()

let solveStageTwo (_ : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.map handleGameII
    |> Seq.sum
    |> printfn "%A"
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0

[<Fact>]
let testParseGame () =
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
    |> parseGame
    |> should equal (1, (4,2,6)) // this is not right
