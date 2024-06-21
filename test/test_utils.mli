open! Core

module Env : sig
  type t [@@deriving sexp_of]

  val with_fresh: (t -> 'a) -> 'a
  val write_file : t -> name:string -> content:string -> unit
  val read_file : t -> name:string -> string
  val abs_path: t -> name:string -> string
  val exec: t -> string -> string list -> unit
end
