module Tests

open System
open Xunit
open Hedgehog
open Hedgehog.Xunit
open Program

[<Property>]
let ``myId works for all values`` (xs: string) = myId xs = xs
