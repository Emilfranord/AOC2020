module AOC.Trebuchet

open Xunit
open FsUnit.Xunit
open System;
open System.Text.RegularExpressions;

let extract s =
    Regex.Matches(s, @"\d") 
    |> Seq.map (fun x ->  x.Value )
    |> (fun x -> sprintf "%s%s" (x |> Seq.head) (x |> Seq.rev |> Seq.head))
    |> int64

let conversion =
    [("one","o1e");
    ("two","t2o");
    ("three","t3e");
    ("four", "f4r");
    ("five", "f5e");
    ("six","s6x");
    ("seven","s7n");
    ("eight","e8t");
    ("nine", "n9e")]

let convert (s:string) =
    let convKey idx = List.item idx conversion |> fst
    let convVal idx = List.item idx conversion |> snd

    List.fold (fun (a:string) b -> a.Replace(convKey b ,convVal b) ) s [0 .. 8]

let solveStageOne (scanner: Kattio.Scanner) : unit =
    [while scanner.hasNext() do scanner.Next()]
    |> Seq.map extract
    |> Seq.sum
    |> printf "%d\n"

let solveStageTwo (scanner : Kattio.Scanner) : unit =
    [while scanner.hasNext() do scanner.Next()]
    |> Seq.map convert
    |> Seq.map extract
    |> Seq.sum
    |> printf "%d\n"

[<Fact>]
let testZero () = 
    0 |> should equal 0

[<Fact>]
let testExtract () = 
    extract "1abc2" |> should equal 12L
    extract "pqr3stu8vwx" |> should equal 38L
    extract "a1b2c3d4e5f" |> should equal 15L
    extract "treb7uchet" |> should equal 77L

[<Fact>]
let testConvert () = 
    "two1nine"          |> convert |> extract |> should equal 29L
    "eightwothree"      |> convert |> extract |> should equal 83L
    "abcone2threexyz"   |> convert |> extract |> should equal 13L
    "xtwone3four"       |> convert |> extract |> should equal 24L
    "4nineeightseven2"  |> convert |> extract |> should equal 42L
    "zoneight234"       |> convert |> extract |> should equal 14L
    "7pqrstsixteen"     |> convert |> extract |> should equal 76L

