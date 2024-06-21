open! Core

module Env = struct
  type t = string

  let sexp_of_t = sexp_of_string

  let exec dir prog args =
    let { Core_unix.Process_info.pid; stdin = _; stdout; stderr } =
      Core_unix.create_process_env ~working_dir:dir ~prog ~args ~env:(`Extend []) ()
    in
    (match Core_unix.waitpid pid with
     | Ok () -> ()
     | Error exit_or_signal ->
       print_s [%message "process exit" (exit_or_signal : Core_unix.Exit_or_signal.error)]);
    let stdout = stdout |> Core_unix.in_channel_of_descr |> In_channel.input_all in
    let stderr = stderr |> Core_unix.in_channel_of_descr |> In_channel.input_all in
    if not (String.is_empty stdout)
    then (
      print_endline "STDOUT:";
      print_endline stdout);
    if not (String.is_empty stderr)
    then (
      print_endline "STDERR:";
      print_endline stderr);
    ()
  ;;

  let rng = Random.State.make [| 0 |]

  let new_tmp () =
    let dirname =
      Stdlib.Filename.get_temp_dir_name ()
      ^ "/"
      ^ Int64.to_string (Random.State.int64 rng Int64.max_value)
    in
    exec "/" "mkdir" [ dirname ];
    dirname
  ;;

  let abs_path t ~name = t ^ "/" ^ name
  let write_file t ~name ~content = Out_channel.write_all (abs_path t ~name) ~data:content
  let read_file t ~name = In_channel.read_all (abs_path t ~name)

  let with_fresh f =
    let env = new_tmp () in
    Exn.protect ~f:(fun () -> f env) ~finally:(fun () -> exec env "rm" [ "-rf"; env ])
  ;;
end
