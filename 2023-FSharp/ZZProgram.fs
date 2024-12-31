[<EntryPoint>]
let main args =
    match Array.tryItem 0 args with
    | Some "1" -> () |> Kattio.Scanner |> AOC.Lens.solveStageOne
    | Some "2" -> () |> Kattio.Scanner |> AOC.Lens.solveStageTwo
    | _ -> failwith "error: args"
    0
