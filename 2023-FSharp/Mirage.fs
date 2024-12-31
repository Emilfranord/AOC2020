module AOC.Mirage

open Xunit
open FsUnit.Xunit
open System

let differences numbers =
    List.pairwise numbers
    |> List.map (fun (car, cdr) -> cdr - car)

let rec allDifferences numbers =
    let currentNumbers = List.head numbers
    match Seq.forall (fun x -> x=0) currentNumbers with
    | true -> numbers
    | false -> 
        let newNumbers = differences currentNumbers
        allDifferences (newNumbers :: numbers)

let rec extrapolate numbers (lastBelow:int) = 
    match numbers with 
    | [] -> lastBelow
    | head :: tail -> 
        extrapolate (tail) (List.last head + lastBelow)

let rec extrapolateBack numbers (firstBelow:int) =
    match numbers with
    | [] -> firstBelow
    | head :: tail -> extrapolateBack (tail) (List.head head - firstBelow)

let solveLine (s:string) =
    s.Split ' '
    |> Seq.map int
    |> Seq.toList
    |> (fun x -> [x] |> allDifferences)
    |> (fun x -> extrapolate x 0)


let solveLineBack (s:string) =
    s.Split ' '
    |> Seq.map int
    |> Seq.toList
    |> (fun x -> [x] |> allDifferences)
    |> (fun x -> extrapolateBack x 0)

let solveStageOne (scanner : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.toList
    |> Seq.map solveLine
    |> Seq.sum
    |> printf "%A"
    ()


let solveStageTwo (scanner : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.toList
    |> Seq.map solveLineBack
    |> Seq.sum
    |> printf "%A"
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0

[<Fact>]
let testDifferences () = 
    [0;3;6;9;12;15]
    |> differences
    |> should equal [3; 3; 3; 3; 3]

[<Fact>]
let testDifferencesII () = 
    [0;3;6;9]
    |> differences
    |> should equal [3; 3; 3]

[<Fact>]
let testAllDifferences () = 
    [[0;3;6;9;12;15]]
    |> allDifferences
    |> List.rev
    |> should equal [[0;3;6;9;12;15];[3;3;3;3;3];[0;0;0;0]]

[<Fact>]
let testSolveLine ()  =
    "0 3 6 9 12 15"
    |> solveLine
    |> should equal 18

[<Fact>]
let testSolveLineI ()  =
    "1 3 6 10 15 21"
    |> solveLine
    |> should equal 28

[<Fact>]
let testSolveLineII () =
    "10 13 16 21 30 45"
    |> solveLine
    |> should equal 68