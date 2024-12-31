module AOC.GearRatios

open Xunit
open FsUnit.Xunit

open System
open System.Text.RegularExpressions

type Coordinate = int * int

type element = 
    | Symbol of Coordinate * char
    | PartNumber of List<Coordinate> * int

let generateCoords start amount lineNumber =
    [start .. (start + amount-1)] |> List.map (fun x -> Coordinate(x, lineNumber))

let matchHandle (m:Match) (lineNumber:int) : element =
    match Int32.TryParse m.Value with 
    | true, number  -> PartNumber ( generateCoords m.Index m.Length lineNumber, number)
    | false, _      -> Symbol (Coordinate (m.Index, lineNumber), m.Value |> Seq.head )

let lineParse (line:string) (lineNumber:int)=
    let pattern = @"(\d+|[^\d.\n])"
    Regex.Matches(line, pattern)
    |> Seq.cast
    |> List.ofSeq
    |> List.map (fun m -> matchHandle m lineNumber)

let fullParse () =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> List.ofSeq
    |> List.mapi (fun line str -> lineParse str line)
    |> List.collect id

let aroundCoord coord : List<Coordinate>=
    let x, y = coord
    [(x-1,y-1);(x,y-1);(x+1,y-1);
     (x-1,y+0);(x,y+0);(x+1,y+0);
     (x-1,y+1);(x,y+1);(x+1,y+1)]


let aroundEveryCoord coords =
    List.map aroundCoord coords
    |> List.collect id
    |> Set.ofList

let numberValue ele targetCoords =
    match ele with
    | Symbol (_) -> 0
    | PartNumber (coords, num) -> 
        match List.exists (fun x -> (Set.contains x targetCoords)) coords with
        | true -> num
        | false -> 0

let elementsAround elements (coord:Coordinate) =
    let adjacent = aroundEveryCoord (List.singleton coord)
    List.map (fun x -> numberValue x adjacent) elements


let solveStageOne (_ : Kattio.Scanner) : unit =
    let parsed = fullParse ()
    
    let symbolsCoords =
        parsed |> List.map (fun x -> match x with |Symbol (c,_) -> c | PartNumber (_,_) -> (-100,-100))

    let allAdjacent = aroundEveryCoord symbolsCoords

    let numbersII =
        parsed
        |> List.map (fun x -> numberValue x allAdjacent) 
        |> List.sum
        
    printf "%A" numbersII
    ()



let solveStageTwo (_ : Kattio.Scanner) : unit =
    let parsed = fullParse ()
    
    let symbolsCoords =
        parsed 
        |> List.map (fun x -> match x with |Symbol (c,ch) -> (c,ch) | PartNumber (_,_) -> ((-100,-100), '0'))
        |> List.filter (fun (_,ch) -> ch = '*')
        |> List.map (fun (c,_) -> c)
    
    let gearPairs =
        List.map (fun x -> elementsAround parsed x ) symbolsCoords
        |> List.map (fun x -> List.filter (fun y -> y<>0) x )
        |> List.filter (fun x -> List.length x = 2 )
        |> List.map (fun x -> List.item 0 x * List.item 1 x)
        |> List.sum
    printfn "%A" gearPairs
    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0

