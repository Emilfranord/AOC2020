module AOC.Scratchcards

open Xunit
open FsUnit.Xunit

open System

type card = int * Set<int> * Set<int>

let parseLine (s:string) =
    let s = s.Replace(':','|')
    let segments = s.Split '|'


    let (gameNumber:int) = ((segments[0]).Split ' ') |> Seq.ofArray |> Seq.rev |> Seq.head |> int
    let numbers' = (segments[1]).Split ' '  |> Set.ofArray |> Set.filter (fun x -> x<>"")|> Set.map int
    let wins' = (segments[2]).Split ' '  |> Set.ofArray |> Set.filter (fun x -> x<>"")|> Set.map int

    (gameNumber, numbers', wins')

let gameValue (game:card) =
    let (_, numbers, wins) = game
    let inBoth = Set.intersect numbers wins
    inBoth |> Set.toList |> List.length |> (fun x -> pown 2 (x-1))

let extraCards (game:card) =
    let (_, numbers, wins) = game
    let inBoth = Set.intersect numbers wins
    inBoth |> Set.toList |> List.length

let solveStageOne (scanner : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> Seq.map parseLine
    |> Seq.map gameValue
    |> Seq.sum
    |> printfn "%A"
    ()

let moreCards (card:card) (mapping:Map<int,card>) (amountFunc: card -> int) =
    let (g, _,_) = card
    let amount = amountFunc card
    [ g+1 .. (g + amount)]
    |> List.map (fun x -> Map.tryFind x mapping)
    |> List.choose id

let solveStageTwo (scanner : Kattio.Scanner) : unit =
    let (cards:seq<card>) = 
        Seq.initInfinite (fun _ -> Console.ReadLine())
        |> Seq.takeWhile (fun line -> line <> null)
        |> Seq.map parseLine
        |> Seq.toList
        |> Seq.ofList

    let cardMap =
        cards
        |>Seq.map (fun (g,n,w) -> (g,(g,n,w)))
        |> Map.ofSeq
    
    let cards' =
        cards
        |> Seq.map (fun x -> moreCards x cardMap extraCards)
        |> Seq.map Seq.ofList
        |> Seq.collect id

    let rec aux car acc =
        match car with
        | [] -> acc
        | head::tail -> 
            let newCards = moreCards head cardMap gameValue
            let amount = List.length newCards
            aux (newCards @ tail) (acc + amount)

    let generatedCards = aux (List.ofSeq cards') 0

    generatedCards + (Seq.length cards) + (Seq.length cards')
    |> printf "%A"

    ()

[<Fact>]
let testZero () = 
    0 |> should equal 0

[<Fact>]
let testSplit () = 
    "Card 1: 2 | 3" 
    |> parseLine
    |> should equal (1, [2]|>Set.ofList, [3]|>Set.ofList)


[<Fact>]
let testValue () = 
    "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53" 
    |> parseLine
    |> gameValue
    |> should equal 8

[<Fact>]
let testRealInp () = 
    "Card   1:  5 27 94 20 50  7 98 41 67 34 | 34  9 20 90  7 77 44 71 27 12 98  1 79 96 24 51 25 84 67 41  5 13 78 31 26"
    |> parseLine
    |> gameValue
    |> should equal 128

