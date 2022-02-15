open FSharpPlus
open FSharp.Data

[<EntryPoint>]
let main argv =
    [ 1 .. 13 ] |> listGen |> printfn "%A"

    0 // return an integer exit code
