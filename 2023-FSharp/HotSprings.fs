module AOC.HotSprings

open Xunit
open FsUnit.Xunit
open System

type Spring = Operational | Damaged | Unknown

type NumberFormat = list<int>

type Row =  list<Spring> * NumberFormat

let toSprings s =
    s
    |> Seq.map (fun ch -> match ch with | '.' -> Operational | '#' -> Damaged | '?' -> Unknown | _ -> failwith "nice") 
    |> Seq.toList

let toNumberFormat (springs:list<Spring>) : NumberFormat = 
    let upgradeAcc  acc (item:Spring) =
        let accH = List.head acc
        match (accH, item) with
        | (spr, num), newSpr when spr = newSpr  -> (newSpr, num + 1)  :: (List.tail acc)
        | (_, _),   newSpr ->                      (newSpr, 1) :: acc

    let rec aux acc remaining =
        match remaining with
        | [] -> acc
        | head :: tail -> aux (upgradeAcc acc head) tail

    let groups = aux [(Operational, 0)] springs

    groups
    |> List.filter (fun (s,_) -> match s with | Operational -> false | Damaged -> true | Unknown -> false ) 
    |> List.rev
    |> List.map (fun (_, n) -> n)

let validRow row = 
    let springs, numbers = row
    let converted = toNumberFormat springs
    numbers = converted 

let parseRow (s:string) =
    let spl = s.Split ' '
    let springs, numbers = spl[0] |> toSprings, spl[1].Split ',' |> Array.toList |> List.map int

    (springs, numbers)

let rec generateKnowns (acc:List<Spring>) springs = 
    seq {
        match acc, springs with
        | x, [] -> x
        | _, sHead::sTail when sHead = Unknown -> 
            yield! generateKnowns (Damaged::acc) (sTail)
            yield! generateKnowns (Operational::acc) (sTail)
        | _, sHead::sTail -> 
            yield! generateKnowns (sHead::acc) (sTail)
    }

let safeGenerateKnowns springs = springs |> generateKnowns [] |> Seq.toList |> List.map List.rev

let numberVerified (row:Row) =
    let (springs, numbers) = row
    let allSprings = safeGenerateKnowns springs
    allSprings 
    |> List.map (fun x -> validRow (x,numbers))
    |> List.filter id
    |> List.length

let fiveRow (row:Row) =
    let (springs, numbers) = row
    let newSprings = springs @ springs @ springs @ springs @ springs
    let newNumbers = numbers @ numbers @ numbers @ numbers @ numbers
    (newSprings,newNumbers)

let solveStageOne (scanner : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> List.ofSeq
    |> List.map parseRow
    |> List.map numberVerified
    |> List.sum
    |> printf "%A"
    ()

let solveStageTwo (scanner : Kattio.Scanner) : unit =
    Seq.initInfinite (fun _ -> Console.ReadLine())
    |> Seq.takeWhile (fun line -> line <> null)
    |> List.ofSeq
    |> List.map parseRow
    |> List.map fiveRow
    |> List.map numberVerified
    |> List.sum
    |> printf "%A"
    ()

[<Fact>]
let testToNumberFormat () =
    "#.#.###" |> toSprings |> toNumberFormat |> should equal [1;1;3]
    ".#...#....###." |> toSprings |> toNumberFormat |> should equal [1;1;3]
    ".#.###.#.######" |> toSprings |> toNumberFormat |> should equal [1;3;1;6]

[<Fact>]
let testValidRow () =
    ("#.#.###" |> toSprings,  [1;1;3]) |> validRow |> should equal true

[<Fact>]
let testParse () =
    "#....######..#####. 1,6,5" |> parseRow |> validRow |> should equal true

[<Fact>]
let testGenerateKnowns () = 
    ".?" |> toSprings |> safeGenerateKnowns |> should equal [[Operational; Damaged]; [Operational; Operational]]
    "???.###" |> toSprings |> safeGenerateKnowns |> List.length |> should equal 8

[<Fact>]
let testNumberVerified () =
    "???.### 1,1,3" |> parseRow |> numberVerified |> should equal 1
    ".??..??...?##. 1,1,3"  |> parseRow |> numberVerified |> should equal 4
    "?#?#?#?#?#?#?#? 1,3,1,6"  |> parseRow |> numberVerified |> should equal 1
    "?###???????? 3,2,1" |> parseRow |> numberVerified |> should equal 10
    ()