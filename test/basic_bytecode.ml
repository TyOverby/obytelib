module Adder =
  [%demo
  let add x y = x, y;;

  print_endline "hello!"]

open! Core
open! Test_utils

let%expect_test "add bytecode" =
  Env.with_fresh (fun env ->
    Env.write_file env ~name:"test.ml" ~content:Adder.ppx_demo_string;
    Env.exec env "ocamlc" [ "test.ml"; "-color"; "never"; "-o"; "test.bc" ];
    Env.write_file env ~name:"camlheader" ~content:"#";
    Env.exec env "ls" [];
    let bytefile = Obytelib.Bytefile.read (Env.abs_path env ~name:"test.bc") in
    Obytelib.Bytefile.print Out_channel.stdout bytefile;
    Out_channel.flush Out_channel.stdout;
    Obytelib.Interp.eval_bytefile bytefile;
    ());
  [%expect
    {|
    STDOUT:
    camlheader
    test.bc
    test.cmi
    test.cmo
    test.ml

    VM path    = "/home/tyoverby/workspace/ocaml/obytelib/_opam/bin/ocamlrun"
    VM arg     =
    Version    = 031
    Extra size = 0

    ########> INDEX

    <name>    <addr>    <size>
    --------------------------
      CODE        61     11336
      DLPT     11397         0
      DLLS     11397         0
      PRIM     11397      7858
      DATA     19255       599
      SYMB     19854       359
      CRCS     20213      1217

    ########> CRCS

    2127400fd7211dedaa77f2f8e59a6b0a  CamlinternalAtomic
    8f8f634558798ee408df3c50a5539b15  CamlinternalFormatBasics
    f2258b20d01bb253d1fc3fbb997fdac8  Std_exit
    79b0e9d3b6f7fed07eb3cc2abb961b91  Stdlib
    -  Stdlib__Arg
    -  Stdlib__Array
    -  Stdlib__ArrayLabels
    -  Stdlib__Atomic
    -  Stdlib__Bigarray
    -  Stdlib__Bool
    -  Stdlib__Buffer
    -  Stdlib__Bytes
    -  Stdlib__BytesLabels
    -  Stdlib__Callback
    -  Stdlib__Char
    -  Stdlib__Complex
    -  Stdlib__Digest
    -  Stdlib__Either
    -  Stdlib__Ephemeron
    -  Stdlib__Filename
    -  Stdlib__Float
    -  Stdlib__Format
    -  Stdlib__Fun
    -  Stdlib__Gc
    -  Stdlib__Genlex
    -  Stdlib__Hashtbl
    -  Stdlib__In_channel
    -  Stdlib__Int
    -  Stdlib__Int32
    -  Stdlib__Int64
    -  Stdlib__Lazy
    -  Stdlib__Lexing
    -  Stdlib__List
    -  Stdlib__ListLabels
    -  Stdlib__Map
    -  Stdlib__Marshal
    -  Stdlib__MoreLabels
    -  Stdlib__Nativeint
    -  Stdlib__Obj
    -  Stdlib__Oo
    -  Stdlib__Option
    -  Stdlib__Out_channel
    -  Stdlib__Parsing
    -  Stdlib__Pervasives
    -  Stdlib__Printexc
    -  Stdlib__Printf
    -  Stdlib__Queue
    -  Stdlib__Random
    -  Stdlib__Result
    -  Stdlib__Scanf
    -  Stdlib__Seq
    -  Stdlib__Set
    -  Stdlib__Stack
    -  Stdlib__StdLabels
    -  Stdlib__Stream
    -  Stdlib__String
    -  Stdlib__StringLabels
    -  Stdlib__Sys
    -  Stdlib__Uchar
    -  Stdlib__Unit
    -  Stdlib__Weak
    5fa5cc23241e86c97074a700f0deea68  Test

    ########> SYMB

       0: Predef { name = "Out_of_memory"; stamp = 19 }
       1: Predef { name = "Sys_error"; stamp = 23 }
       2: Predef { name = "Failure"; stamp = 21 }
       3: Predef { name = "Invalid_argument"; stamp = 20 }
       4: Predef { name = "End_of_file"; stamp = 24 }
       5: Predef { name = "Division_by_zero"; stamp = 25 }
       6: Predef { name = "Not_found"; stamp = 22 }
       7: Predef { name = "Match_failure"; stamp = 18 }
       8: Predef { name = "Stack_overflow"; stamp = 26 }
       9: Predef { name = "Sys_blocked_io"; stamp = 27 }
      10: Predef { name = "Assert_failure"; stamp = 28 }
      11: Predef { name = "Undefined_recursive_module"; stamp = 29 }
      12: Global "CamlinternalFormatBasics"
      13: Global "CamlinternalAtomic"
      46: Global "Stdlib"
      48: Global "Test"
      49: Global "Std_exit"

    ########> DATA

       0:  < "Out_of_memory"; -1 >                              (* Out_of_memory *)
       1:  < "Sys_error"; -2 >                                      (* Sys_error *)
       2:  < "Failure"; -3 >                                          (* Failure *)
       3:  < "Invalid_argument"; -4 >                        (* Invalid_argument *)
       4:  < "End_of_file"; -5 >                                  (* End_of_file *)
       5:  < "Division_by_zero"; -6 >                        (* Division_by_zero *)
       6:  < "Not_found"; -7 >                                      (* Not_found *)
       7:  < "Match_failure"; -8 >                              (* Match_failure *)
       8:  < "Stack_overflow"; -9 >                            (* Stack_overflow *)
       9:  < "Sys_blocked_io"; -10 >                           (* Sys_blocked_io *)
      10:  < "Assert_failure"; -11 >                           (* Assert_failure *)
      11:  < "Undefined_recursive_module"; -12 >   (* Undefined_recursive_module *)
      12:  0                                         (* CamlinternalFormatBasics *)
      13:  0                                               (* CamlinternalAtomic *)
      14:  "%,"
      15:  "really_input"
      16:  "input"
      17:  [0| 0; [0| 6; 0 ] ]
      18:  [0| 0; [0| 7; 0 ] ]
      19:  "output_substring"
      20:  "output"
      21:  [0| 1; [0| 3; [0| 4; [0| 6; 0 ] ] ] ]
      22:  [0| 1; [0| 3; [0| 4; [0| 7; 0 ] ] ] ]
      23:  "%.12g"
      24:  "."
      25:  "%d"
      26:  "false"
      27:  "true"
      28:  [0| 1 ]
      29:  [0| 0 ]
      30:  "false"
      31:  "true"
      32:  "bool_of_string"
      33:  "true"
      34:  "false"
      35:  "char_of_int"
      36:  "index out of bounds"
      37:  "Pervasives.array_bound_error"
      38:  "Stdlib.Exit"
      39:  9218868437227405312L
      40:  -4503599627370496L
      41:  9218868437227405313L
      42:  9218868437227405311L
      43:  4503599627370496L
      44:  4372995238176751616L
      45:  "Pervasives.do_at_exit"
      46:  0                                                           (* Stdlib *)
      47:  "hello!"
      48:  0                                                             (* Test *)
      49:  0                                                         (* Std_exit *)

    ########> PRIM

       0:  caml_abs_float
       1:  caml_acos_float
       2:  caml_acosh_float
       3:  caml_add_float
       4:  caml_alloc_dummy
       5:  caml_alloc_dummy_float
       6:  caml_alloc_dummy_function
       7:  caml_alloc_dummy_infix
       8:  caml_array_append
       9:  caml_array_blit
      10:  caml_array_concat
      11:  caml_array_fill
      12:  caml_array_get
      13:  caml_array_get_addr
      14:  caml_array_set
      15:  caml_array_set_addr
      16:  caml_array_sub
      17:  caml_array_unsafe_get
      18:  caml_array_unsafe_set
      19:  caml_asin_float
      20:  caml_asinh_float
      21:  caml_atan2_float
      22:  caml_atan_float
      23:  caml_atanh_float
      24:  caml_ba_blit
      25:  caml_ba_change_layout
      26:  caml_ba_create
      27:  caml_ba_dim
      28:  caml_ba_dim_1
      29:  caml_ba_dim_2
      30:  caml_ba_dim_3
      31:  caml_ba_fill
      32:  caml_ba_get_1
      33:  caml_ba_get_2
      34:  caml_ba_get_3
      35:  caml_ba_get_generic
      36:  caml_ba_kind
      37:  caml_ba_layout
      38:  caml_ba_num_dims
      39:  caml_ba_reshape
      40:  caml_ba_set_1
      41:  caml_ba_set_2
      42:  caml_ba_set_3
      43:  caml_ba_set_generic
      44:  caml_ba_slice
      45:  caml_ba_sub
      46:  caml_ba_uint8_get16
      47:  caml_ba_uint8_get32
      48:  caml_ba_uint8_get64
      49:  caml_ba_uint8_set16
      50:  caml_ba_uint8_set32
      51:  caml_ba_uint8_set64
      52:  caml_backtrace_status
      53:  caml_blit_bytes
      54:  caml_blit_string
      55:  caml_bswap16
      56:  caml_bytes_compare
      57:  caml_bytes_equal
      58:  caml_bytes_get
      59:  caml_bytes_get16
      60:  caml_bytes_get32
      61:  caml_bytes_get64
      62:  caml_bytes_greaterequal
      63:  caml_bytes_greaterthan
      64:  caml_bytes_lessequal
      65:  caml_bytes_lessthan
      66:  caml_bytes_notequal
      67:  caml_bytes_of_string
      68:  caml_bytes_set
      69:  caml_bytes_set16
      70:  caml_bytes_set32
      71:  caml_bytes_set64
      72:  caml_cbrt_float
      73:  caml_ceil_float
      74:  caml_channel_descriptor
      75:  caml_classify_float
      76:  caml_compare
      77:  caml_convert_raw_backtrace
      78:  caml_convert_raw_backtrace_slot
      79:  caml_copysign_float
      80:  caml_cos_float
      81:  caml_cosh_float
      82:  caml_create_bytes
      83:  caml_create_string
      84:  caml_div_float
      85:  caml_dynlink_add_primitive
      86:  caml_dynlink_close_lib
      87:  caml_dynlink_get_current_libs
      88:  caml_dynlink_lookup_symbol
      89:  caml_dynlink_open_lib
      90:  caml_ensure_stack_capacity
      91:  caml_ephe_blit_data
      92:  caml_ephe_blit_key
      93:  caml_ephe_check_data
      94:  caml_ephe_check_key
      95:  caml_ephe_create
      96:  caml_ephe_get_data
      97:  caml_ephe_get_data_copy
      98:  caml_ephe_get_key
      99:  caml_ephe_get_key_copy
     100:  caml_ephe_set_data
     101:  caml_ephe_set_key
     102:  caml_ephe_unset_data
     103:  caml_ephe_unset_key
     104:  caml_eq_float
     105:  caml_equal
     106:  caml_erf_float
     107:  caml_erfc_float
     108:  caml_eventlog_pause
     109:  caml_eventlog_resume
     110:  caml_exp2_float
     111:  caml_exp_float
     112:  caml_expm1_float
     113:  caml_fill_bytes
     114:  caml_fill_string
     115:  caml_final_register
     116:  caml_final_register_called_without_value
     117:  caml_final_release
     118:  caml_float_compare
     119:  caml_float_of_int
     120:  caml_float_of_string
     121:  caml_floatarray_blit
     122:  caml_floatarray_create
     123:  caml_floatarray_get
     124:  caml_floatarray_set
     125:  caml_floatarray_unsafe_get
     126:  caml_floatarray_unsafe_set
     127:  caml_floor_float
     128:  caml_fma_float
     129:  caml_fmod_float
     130:  caml_format_float
     131:  caml_format_int
     132:  caml_fresh_oo_id
     133:  caml_frexp_float
     134:  caml_gc_compaction
     135:  caml_gc_counters
     136:  caml_gc_full_major
     137:  caml_gc_get
     138:  caml_gc_huge_fallback_count
     139:  caml_gc_major
     140:  caml_gc_major_slice
     141:  caml_gc_minor
     142:  caml_gc_minor_words
     143:  caml_gc_quick_stat
     144:  caml_gc_set
     145:  caml_gc_stat
     146:  caml_ge_float
     147:  caml_get_current_callstack
     148:  caml_get_current_environment
     149:  caml_get_exception_backtrace
     150:  caml_get_exception_raw_backtrace
     151:  caml_get_global_data
     152:  caml_get_major_bucket
     153:  caml_get_major_credit
     154:  caml_get_minor_free
     155:  caml_get_public_method
     156:  caml_get_section_table
     157:  caml_greaterequal
     158:  caml_greaterthan
     159:  caml_gt_float
     160:  caml_hash
     161:  caml_hexstring_of_float
     162:  caml_hypot_float
     163:  caml_input_value
     164:  caml_input_value_from_bytes
     165:  caml_install_signal_handler
     166:  caml_int32_add
     167:  caml_int32_and
     168:  caml_int32_bits_of_float
     169:  caml_int32_bswap
     170:  caml_int32_compare
     171:  caml_int32_div
     172:  caml_int32_float_of_bits
     173:  caml_int32_format
     174:  caml_int32_mod
     175:  caml_int32_mul
     176:  caml_int32_neg
     177:  caml_int32_of_float
     178:  caml_int32_of_int
     179:  caml_int32_of_string
     180:  caml_int32_or
     181:  caml_int32_shift_left
     182:  caml_int32_shift_right
     183:  caml_int32_shift_right_unsigned
     184:  caml_int32_sub
     185:  caml_int32_to_float
     186:  caml_int32_to_int
     187:  caml_int32_xor
     188:  caml_int64_add
     189:  caml_int64_add_native
     190:  caml_int64_and
     191:  caml_int64_and_native
     192:  caml_int64_bits_of_float
     193:  caml_int64_bswap
     194:  caml_int64_compare
     195:  caml_int64_div
     196:  caml_int64_div_native
     197:  caml_int64_float_of_bits
     198:  caml_int64_format
     199:  caml_int64_mod
     200:  caml_int64_mod_native
     201:  caml_int64_mul
     202:  caml_int64_mul_native
     203:  caml_int64_neg
     204:  caml_int64_neg_native
     205:  caml_int64_of_float
     206:  caml_int64_of_int
     207:  caml_int64_of_int32
     208:  caml_int64_of_nativeint
     209:  caml_int64_of_string
     210:  caml_int64_or
     211:  caml_int64_or_native
     212:  caml_int64_shift_left
     213:  caml_int64_shift_right
     214:  caml_int64_shift_right_unsigned
     215:  caml_int64_sub
     216:  caml_int64_sub_native
     217:  caml_int64_to_float
     218:  caml_int64_to_int
     219:  caml_int64_to_int32
     220:  caml_int64_to_nativeint
     221:  caml_int64_xor
     222:  caml_int64_xor_native
     223:  caml_int_as_pointer
     224:  caml_int_compare
     225:  caml_int_of_float
     226:  caml_int_of_string
     227:  caml_invoke_traced_function
     228:  caml_lazy_make_forward
     229:  caml_ldexp_float
     230:  caml_le_float
     231:  caml_lessequal
     232:  caml_lessthan
     233:  caml_lex_engine
     234:  caml_log10_float
     235:  caml_log1p_float
     236:  caml_log2_float
     237:  caml_log_float
     238:  caml_lt_float
     239:  caml_make_array
     240:  caml_make_float_vect
     241:  caml_make_vect
     242:  caml_marshal_data_size
     243:  caml_md5_chan
     244:  caml_md5_string
     245:  caml_memprof_start
     246:  caml_memprof_stop
     247:  caml_ml_bytes_length
     248:  caml_ml_channel_size
     249:  caml_ml_channel_size_64
     250:  caml_ml_close_channel
     251:  caml_ml_debug_info_status
     252:  caml_ml_enable_runtime_warnings
     253:  caml_ml_flush
     254:  caml_ml_input
     255:  caml_ml_input_char
     256:  caml_ml_input_int
     257:  caml_ml_input_scan_line
     258:  caml_ml_is_buffered
     259:  caml_ml_open_descriptor_in
     260:  caml_ml_open_descriptor_out
     261:  caml_ml_out_channels_list
     262:  caml_ml_output
     263:  caml_ml_output_bytes
     264:  caml_ml_output_char
     265:  caml_ml_output_int
     266:  caml_ml_pos_in
     267:  caml_ml_pos_in_64
     268:  caml_ml_pos_out
     269:  caml_ml_pos_out_64
     270:  caml_ml_runtime_warnings_enabled
     271:  caml_ml_seek_in
     272:  caml_ml_seek_in_64
     273:  caml_ml_seek_out
     274:  caml_ml_seek_out_64
     275:  caml_ml_set_binary_mode
     276:  caml_ml_set_buffered
     277:  caml_ml_set_channel_name
     278:  caml_ml_string_length
     279:  caml_modf_float
     280:  caml_mul_float
     281:  caml_nativeint_add
     282:  caml_nativeint_and
     283:  caml_nativeint_bswap
     284:  caml_nativeint_compare
     285:  caml_nativeint_div
     286:  caml_nativeint_format
     287:  caml_nativeint_mod
     288:  caml_nativeint_mul
     289:  caml_nativeint_neg
     290:  caml_nativeint_of_float
     291:  caml_nativeint_of_int
     292:  caml_nativeint_of_int32
     293:  caml_nativeint_of_string
     294:  caml_nativeint_or
     295:  caml_nativeint_shift_left
     296:  caml_nativeint_shift_right
     297:  caml_nativeint_shift_right_unsigned
     298:  caml_nativeint_sub
     299:  caml_nativeint_to_float
     300:  caml_nativeint_to_int
     301:  caml_nativeint_to_int32
     302:  caml_nativeint_xor
     303:  caml_neg_float
     304:  caml_neq_float
     305:  caml_new_lex_engine
     306:  caml_nextafter_float
     307:  caml_notequal
     308:  caml_obj_add_offset
     309:  caml_obj_block
     310:  caml_obj_dup
     311:  caml_obj_make_forward
     312:  caml_obj_raw_field
     313:  caml_obj_reachable_words
     314:  caml_obj_set_raw_field
     315:  caml_obj_set_tag
     316:  caml_obj_tag
     317:  caml_obj_truncate
     318:  caml_obj_with_tag
     319:  caml_output_value
     320:  caml_output_value_to_buffer
     321:  caml_output_value_to_bytes
     322:  caml_output_value_to_string
     323:  caml_parse_engine
     324:  caml_power_float
     325:  caml_raw_backtrace_length
     326:  caml_raw_backtrace_next_slot
     327:  caml_raw_backtrace_slot
     328:  caml_realloc_global
     329:  caml_record_backtrace
     330:  caml_register_named_value
     331:  caml_reify_bytecode
     332:  caml_reset_afl_instrumentation
     333:  caml_restore_raw_backtrace
     334:  caml_round_float
     335:  caml_runtime_parameters
     336:  caml_runtime_variant
     337:  caml_set_oo_id
     338:  caml_set_parser_trace
     339:  caml_signbit
     340:  caml_signbit_float
     341:  caml_sin_float
     342:  caml_sinh_float
     343:  caml_sqrt_float
     344:  caml_static_release_bytecode
     345:  caml_string_compare
     346:  caml_string_equal
     347:  caml_string_get
     348:  caml_string_get16
     349:  caml_string_get32
     350:  caml_string_get64
     351:  caml_string_greaterequal
     352:  caml_string_greaterthan
     353:  caml_string_lessequal
     354:  caml_string_lessthan
     355:  caml_string_notequal
     356:  caml_string_of_bytes
     357:  caml_string_set
     358:  caml_sub_float
     359:  caml_sys_argv
     360:  caml_sys_chdir
     361:  caml_sys_close
     362:  caml_sys_const_backend_type
     363:  caml_sys_const_big_endian
     364:  caml_sys_const_int_size
     365:  caml_sys_const_max_wosize
     366:  caml_sys_const_naked_pointers_checked
     367:  caml_sys_const_ostype_cygwin
     368:  caml_sys_const_ostype_unix
     369:  caml_sys_const_ostype_win32
     370:  caml_sys_const_word_size
     371:  caml_sys_executable_name
     372:  caml_sys_exit
     373:  caml_sys_file_exists
     374:  caml_sys_get_argv
     375:  caml_sys_get_config
     376:  caml_sys_getcwd
     377:  caml_sys_getenv
     378:  caml_sys_is_directory
     379:  caml_sys_isatty
     380:  caml_sys_mkdir
     381:  caml_sys_modify_argv
     382:  caml_sys_open
     383:  caml_sys_random_seed
     384:  caml_sys_read_directory
     385:  caml_sys_remove
     386:  caml_sys_rename
     387:  caml_sys_rmdir
     388:  caml_sys_system_command
     389:  caml_sys_time
     390:  caml_sys_time_include_children
     391:  caml_sys_unsafe_getenv
     392:  caml_tan_float
     393:  caml_tanh_float
     394:  caml_terminfo_rows
     395:  caml_trunc_float
     396:  caml_update_dummy
     397:  caml_weak_blit
     398:  caml_weak_check
     399:  caml_weak_create
     400:  caml_weak_get
     401:  caml_weak_get_copy
     402:  caml_weak_set

    ########> CODE

    pc=0            BRANCH L62

    pc=1    L1:     ACC 0
    pc=2            SWITCH [ L2 ] [ L3; L4; L5; L6; L7; L8; L9; L10; L11; L12; L13; L14; L15; L16; L17 ]
    pc=3    L2:     CONSTINT 0
    pc=4            RETURN 1
    pc=5    L3:     ACC 0
    pc=6            GETFIELD 0
    pc=7            PUSH
    pc=8            ACC 0
    pc=9            PUSH
    pc=10           OFFSETCLOSURE 0
    pc=11           APPLY 1
    pc=12           MAKEBLOCK 0 1
    pc=13           RETURN 2
    pc=14   L4:     ACC 0
    pc=15           GETFIELD 0
    pc=16           PUSH
    pc=17           ACC 0
    pc=18           PUSH
    pc=19           OFFSETCLOSURE 0
    pc=20           APPLY 1
    pc=21           MAKEBLOCK 1 1
    pc=22           RETURN 2
    pc=23   L5:     ACC 0
    pc=24           GETFIELD 0
    pc=25           PUSH
    pc=26           ACC 0
    pc=27           PUSH
    pc=28           OFFSETCLOSURE 0
    pc=29           APPLY 1
    pc=30           MAKEBLOCK 2 1
    pc=31           RETURN 2
    pc=32   L6:     ACC 0
    pc=33           GETFIELD 0
    pc=34           PUSH
    pc=35           ACC 0
    pc=36           PUSH
    pc=37           OFFSETCLOSURE 0
    pc=38           APPLY 1
    pc=39           MAKEBLOCK 3 1
    pc=40           RETURN 2
    pc=41   L7:     ACC 0
    pc=42           GETFIELD 0
    pc=43           PUSH
    pc=44           ACC 0
    pc=45           PUSH
    pc=46           OFFSETCLOSURE 0
    pc=47           APPLY 1
    pc=48           MAKEBLOCK 4 1
    pc=49           RETURN 2
    pc=50   L8:     ACC 0
    pc=51           GETFIELD 0
    pc=52           PUSH
    pc=53           ACC 0
    pc=54           PUSH
    pc=55           OFFSETCLOSURE 0
    pc=56           APPLY 1
    pc=57           MAKEBLOCK 5 1
    pc=58           RETURN 2
    pc=59   L9:     ACC 0
    pc=60           GETFIELD 0
    pc=61           PUSH
    pc=62           ACC 0
    pc=63           PUSH
    pc=64           OFFSETCLOSURE 0
    pc=65           APPLY 1
    pc=66           MAKEBLOCK 6 1
    pc=67           RETURN 2
    pc=68   L10:    ACC 0
    pc=69           GETFIELD 0
    pc=70           PUSH
    pc=71           ACC 0
    pc=72           PUSH
    pc=73           OFFSETCLOSURE 0
    pc=74           APPLY 1
    pc=75           MAKEBLOCK 7 1
    pc=76           RETURN 2
    pc=77   L11:    ACC 0
    pc=78           GETFIELD 1
    pc=79           PUSH
    pc=80           ACC 1
    pc=81           GETFIELD 0
    pc=82           PUSH
    pc=83           ACC 1
    pc=84           PUSH
    pc=85           OFFSETCLOSURE 0
    pc=86           APPLY 1
    pc=87           PUSH
    pc=88           ACC 1
    pc=89           MAKEBLOCK 8 2
    pc=90           RETURN 3
    pc=91   L12:    ACC 0
    pc=92           GETFIELD 2
    pc=93           PUSH
    pc=94           ACC 1
    pc=95           GETFIELD 0
    pc=96           PUSH
    pc=97           ACC 1
    pc=98           PUSH
    pc=99           OFFSETCLOSURE 0
    pc=100          APPLY 1
    pc=101          PUSH
    pc=102          ACC 1
    pc=103          PUSH
    pc=104          ACC 2
    pc=105          MAKEBLOCK 9 3
    pc=106          RETURN 3
    pc=107  L13:    ACC 0
    pc=108          GETFIELD 0
    pc=109          PUSH
    pc=110          ACC 0
    pc=111          PUSH
    pc=112          OFFSETCLOSURE 0
    pc=113          APPLY 1
    pc=114          MAKEBLOCK 10 1
    pc=115          RETURN 2
    pc=116  L14:    ACC 0
    pc=117          GETFIELD 0
    pc=118          PUSH
    pc=119          ACC 0
    pc=120          PUSH
    pc=121          OFFSETCLOSURE 0
    pc=122          APPLY 1
    pc=123          MAKEBLOCK 11 1
    pc=124          RETURN 2
    pc=125  L15:    ACC 0
    pc=126          GETFIELD 0
    pc=127          PUSH
    pc=128          ACC 0
    pc=129          PUSH
    pc=130          OFFSETCLOSURE 0
    pc=131          APPLY 1
    pc=132          MAKEBLOCK 12 1
    pc=133          RETURN 2
    pc=134  L16:    ACC 0
    pc=135          GETFIELD 0
    pc=136          PUSH
    pc=137          ACC 0
    pc=138          PUSH
    pc=139          OFFSETCLOSURE 0
    pc=140          APPLY 1
    pc=141          MAKEBLOCK 13 1
    pc=142          RETURN 2
    pc=143  L17:    ACC 0
    pc=144          GETFIELD 0
    pc=145          PUSH
    pc=146          ACC 0
    pc=147          PUSH
    pc=148          OFFSETCLOSURE 0
    pc=149          APPLY 1
    pc=150          MAKEBLOCK 14 1
    pc=151          RETURN 2

    pc=152          RESTART
    pc=153  L18:    GRAB 1
    pc=154          ACC 0
    pc=155          SWITCH [ L19 ] [ L20; L21; L22; L23; L24; L25; L26; L27; L28; L29; L30; L31; L32; L33; L34 ]
    pc=156  L19:    ACC 1
    pc=157          RETURN 2
    pc=158  L20:    ACC 0
    pc=159          GETFIELD 0
    pc=160          PUSH
    pc=161          ACC 2
    pc=162          PUSH
    pc=163          ACC 1
    pc=164          PUSH
    pc=165          OFFSETCLOSURE 0
    pc=166          APPLY 2
    pc=167          MAKEBLOCK 0 1
    pc=168          RETURN 3
    pc=169  L21:    ACC 0
    pc=170          GETFIELD 0
    pc=171          PUSH
    pc=172          ACC 2
    pc=173          PUSH
    pc=174          ACC 1
    pc=175          PUSH
    pc=176          OFFSETCLOSURE 0
    pc=177          APPLY 2
    pc=178          MAKEBLOCK 1 1
    pc=179          RETURN 3
    pc=180  L22:    ACC 0
    pc=181          GETFIELD 0
    pc=182          PUSH
    pc=183          ACC 2
    pc=184          PUSH
    pc=185          ACC 1
    pc=186          PUSH
    pc=187          OFFSETCLOSURE 0
    pc=188          APPLY 2
    pc=189          MAKEBLOCK 2 1
    pc=190          RETURN 3
    pc=191  L23:    ACC 0
    pc=192          GETFIELD 0
    pc=193          PUSH
    pc=194          ACC 2
    pc=195          PUSH
    pc=196          ACC 1
    pc=197          PUSH
    pc=198          OFFSETCLOSURE 0
    pc=199          APPLY 2
    pc=200          MAKEBLOCK 3 1
    pc=201          RETURN 3
    pc=202  L24:    ACC 0
    pc=203          GETFIELD 0
    pc=204          PUSH
    pc=205          ACC 2
    pc=206          PUSH
    pc=207          ACC 1
    pc=208          PUSH
    pc=209          OFFSETCLOSURE 0
    pc=210          APPLY 2
    pc=211          MAKEBLOCK 4 1
    pc=212          RETURN 3
    pc=213  L25:    ACC 0
    pc=214          GETFIELD 0
    pc=215          PUSH
    pc=216          ACC 2
    pc=217          PUSH
    pc=218          ACC 1
    pc=219          PUSH
    pc=220          OFFSETCLOSURE 0
    pc=221          APPLY 2
    pc=222          MAKEBLOCK 5 1
    pc=223          RETURN 3
    pc=224  L26:    ACC 0
    pc=225          GETFIELD 0
    pc=226          PUSH
    pc=227          ACC 2
    pc=228          PUSH
    pc=229          ACC 1
    pc=230          PUSH
    pc=231          OFFSETCLOSURE 0
    pc=232          APPLY 2
    pc=233          MAKEBLOCK 6 1
    pc=234          RETURN 3
    pc=235  L27:    ACC 0
    pc=236          GETFIELD 0
    pc=237          PUSH
    pc=238          ACC 2
    pc=239          PUSH
    pc=240          ACC 1
    pc=241          PUSH
    pc=242          OFFSETCLOSURE 0
    pc=243          APPLY 2
    pc=244          MAKEBLOCK 7 1
    pc=245          RETURN 3
    pc=246  L28:    ACC 0
    pc=247          GETFIELD 1
    pc=248          PUSH
    pc=249          ACC 1
    pc=250          GETFIELD 0
    pc=251          PUSH
    pc=252          ACC 3
    pc=253          PUSH
    pc=254          ACC 2
    pc=255          PUSH
    pc=256          OFFSETCLOSURE 0
    pc=257          APPLY 2
    pc=258          PUSH
    pc=259          ACC 1
    pc=260          MAKEBLOCK 8 2
    pc=261          RETURN 4
    pc=262  L29:    ACC 0
    pc=263          GETFIELD 2
    pc=264          PUSH
    pc=265          ACC 1
    pc=266          GETFIELD 1
    pc=267          PUSH
    pc=268          ACC 2
    pc=269          GETFIELD 0
    pc=270          PUSH
    pc=271          ACC 4
    pc=272          PUSH
    pc=273          ACC 3
    pc=274          PUSH
    pc=275          OFFSETCLOSURE 0
    pc=276          APPLY 2
    pc=277          PUSH
    pc=278          ACC 2
    pc=279          PUSH
    pc=280          ACC 2
    pc=281          MAKEBLOCK 9 3
    pc=282          RETURN 5
    pc=283  L30:    ACC 0
    pc=284          GETFIELD 0
    pc=285          PUSH
    pc=286          ACC 2
    pc=287          PUSH
    pc=288          ACC 1
    pc=289          PUSH
    pc=290          OFFSETCLOSURE 0
    pc=291          APPLY 2
    pc=292          MAKEBLOCK 10 1
    pc=293          RETURN 3
    pc=294  L31:    ACC 0
    pc=295          GETFIELD 0
    pc=296          PUSH
    pc=297          ACC 2
    pc=298          PUSH
    pc=299          ACC 1
    pc=300          PUSH
    pc=301          OFFSETCLOSURE 0
    pc=302          APPLY 2
    pc=303          MAKEBLOCK 11 1
    pc=304          RETURN 3
    pc=305  L32:    ACC 0
    pc=306          GETFIELD 0
    pc=307          PUSH
    pc=308          ACC 2
    pc=309          PUSH
    pc=310          ACC 1
    pc=311          PUSH
    pc=312          OFFSETCLOSURE 0
    pc=313          APPLY 2
    pc=314          MAKEBLOCK 12 1
    pc=315          RETURN 3
    pc=316  L33:    ACC 0
    pc=317          GETFIELD 0
    pc=318          PUSH
    pc=319          ACC 2
    pc=320          PUSH
    pc=321          ACC 1
    pc=322          PUSH
    pc=323          OFFSETCLOSURE 0
    pc=324          APPLY 2
    pc=325          MAKEBLOCK 13 1
    pc=326          RETURN 3
    pc=327  L34:    ACC 0
    pc=328          GETFIELD 0
    pc=329          PUSH
    pc=330          ACC 2
    pc=331          PUSH
    pc=332          ACC 1
    pc=333          PUSH
    pc=334          OFFSETCLOSURE 0
    pc=335          APPLY 2
    pc=336          MAKEBLOCK 14 1
    pc=337          RETURN 3

    pc=338          RESTART
    pc=339  L35:    GRAB 1
    pc=340          ACC 0
    pc=341          SWITCH [ L36 ] [ L37; L38; L39; L40; L41; L42; L43; L44; L45; L46; L47; L48; L49; L50; L51; L52; L53; L54; L55; L56; L57; L58; L59; L60; L61 ]
    pc=342  L36:    ACC 1
    pc=343          RETURN 2
    pc=344  L37:    ACC 0
    pc=345          GETFIELD 0
    pc=346          PUSH
    pc=347          ACC 2
    pc=348          PUSH
    pc=349          ACC 1
    pc=350          PUSH
    pc=351          OFFSETCLOSURE 0
    pc=352          APPLY 2
    pc=353          MAKEBLOCK 0 1
    pc=354          RETURN 3
    pc=355  L38:    ACC 0
    pc=356          GETFIELD 0
    pc=357          PUSH
    pc=358          ACC 2
    pc=359          PUSH
    pc=360          ACC 1
    pc=361          PUSH
    pc=362          OFFSETCLOSURE 0
    pc=363          APPLY 2
    pc=364          MAKEBLOCK 1 1
    pc=365          RETURN 3
    pc=366  L39:    ACC 0
    pc=367          GETFIELD 1
    pc=368          PUSH
    pc=369          ACC 1
    pc=370          GETFIELD 0
    pc=371          PUSH
    pc=372          ACC 3
    pc=373          PUSH
    pc=374          ACC 2
    pc=375          PUSH
    pc=376          OFFSETCLOSURE 0
    pc=377          APPLY 2
    pc=378          PUSH
    pc=379          ACC 1
    pc=380          MAKEBLOCK 2 2
    pc=381          RETURN 4
    pc=382  L40:    ACC 0
    pc=383          GETFIELD 1
    pc=384          PUSH
    pc=385          ACC 1
    pc=386          GETFIELD 0
    pc=387          PUSH
    pc=388          ACC 3
    pc=389          PUSH
    pc=390          ACC 2
    pc=391          PUSH
    pc=392          OFFSETCLOSURE 0
    pc=393          APPLY 2
    pc=394          PUSH
    pc=395          ACC 1
    pc=396          MAKEBLOCK 3 2
    pc=397          RETURN 4
    pc=398  L41:    ACC 0
    pc=399          GETFIELD 3
    pc=400          PUSH
    pc=401          ACC 1
    pc=402          GETFIELD 2
    pc=403          PUSH
    pc=404          ACC 2
    pc=405          GETFIELD 1
    pc=406          PUSH
    pc=407          ACC 3
    pc=408          GETFIELD 0
    pc=409          PUSH
    pc=410          ACC 5
    pc=411          PUSH
    pc=412          ACC 4
    pc=413          PUSH
    pc=414          OFFSETCLOSURE 0
    pc=415          APPLY 2
    pc=416          PUSH
    pc=417          ACC 3
    pc=418          PUSH
    pc=419          ACC 3
    pc=420          PUSH
    pc=421          ACC 3
    pc=422          MAKEBLOCK 4 4
    pc=423          RETURN 6
    pc=424  L42:    ACC 0
    pc=425          GETFIELD 3
    pc=426          PUSH
    pc=427          ACC 1
    pc=428          GETFIELD 2
    pc=429          PUSH
    pc=430          ACC 2
    pc=431          GETFIELD 1
    pc=432          PUSH
    pc=433          ACC 3
    pc=434          GETFIELD 0
    pc=435          PUSH
    pc=436          ACC 5
    pc=437          PUSH
    pc=438          ACC 4
    pc=439          PUSH
    pc=440          OFFSETCLOSURE 0
    pc=441          APPLY 2
    pc=442          PUSH
    pc=443          ACC 3
    pc=444          PUSH
    pc=445          ACC 3
    pc=446          PUSH
    pc=447          ACC 3
    pc=448          MAKEBLOCK 5 4
    pc=449          RETURN 6
    pc=450  L43:    ACC 0
    pc=451          GETFIELD 3
    pc=452          PUSH
    pc=453          ACC 1
    pc=454          GETFIELD 2
    pc=455          PUSH
    pc=456          ACC 2
    pc=457          GETFIELD 1
    pc=458          PUSH
    pc=459          ACC 3
    pc=460          GETFIELD 0
    pc=461          PUSH
    pc=462          ACC 5
    pc=463          PUSH
    pc=464          ACC 4
    pc=465          PUSH
    pc=466          OFFSETCLOSURE 0
    pc=467          APPLY 2
    pc=468          PUSH
    pc=469          ACC 3
    pc=470          PUSH
    pc=471          ACC 3
    pc=472          PUSH
    pc=473          ACC 3
    pc=474          MAKEBLOCK 6 4
    pc=475          RETURN 6
    pc=476  L44:    ACC 0
    pc=477          GETFIELD 3
    pc=478          PUSH
    pc=479          ACC 1
    pc=480          GETFIELD 2
    pc=481          PUSH
    pc=482          ACC 2
    pc=483          GETFIELD 1
    pc=484          PUSH
    pc=485          ACC 3
    pc=486          GETFIELD 0
    pc=487          PUSH
    pc=488          ACC 5
    pc=489          PUSH
    pc=490          ACC 4
    pc=491          PUSH
    pc=492          OFFSETCLOSURE 0
    pc=493          APPLY 2
    pc=494          PUSH
    pc=495          ACC 3
    pc=496          PUSH
    pc=497          ACC 3
    pc=498          PUSH
    pc=499          ACC 3
    pc=500          MAKEBLOCK 7 4
    pc=501          RETURN 6
    pc=502  L45:    ACC 0
    pc=503          GETFIELD 3
    pc=504          PUSH
    pc=505          ACC 1
    pc=506          GETFIELD 2
    pc=507          PUSH
    pc=508          ACC 2
    pc=509          GETFIELD 1
    pc=510          PUSH
    pc=511          ACC 3
    pc=512          GETFIELD 0
    pc=513          PUSH
    pc=514          ACC 5
    pc=515          PUSH
    pc=516          ACC 4
    pc=517          PUSH
    pc=518          OFFSETCLOSURE 0
    pc=519          APPLY 2
    pc=520          PUSH
    pc=521          ACC 3
    pc=522          PUSH
    pc=523          ACC 3
    pc=524          PUSH
    pc=525          ACC 3
    pc=526          MAKEBLOCK 8 4
    pc=527          RETURN 6
    pc=528  L46:    ACC 0
    pc=529          GETFIELD 1
    pc=530          PUSH
    pc=531          ACC 1
    pc=532          GETFIELD 0
    pc=533          PUSH
    pc=534          ACC 3
    pc=535          PUSH
    pc=536          ACC 2
    pc=537          PUSH
    pc=538          OFFSETCLOSURE 0
    pc=539          APPLY 2
    pc=540          PUSH
    pc=541          ACC 1
    pc=542          MAKEBLOCK 9 2
    pc=543          RETURN 4
    pc=544  L47:    ACC 0
    pc=545          GETFIELD 0
    pc=546          PUSH
    pc=547          ACC 2
    pc=548          PUSH
    pc=549          ACC 1
    pc=550          PUSH
    pc=551          OFFSETCLOSURE 0
    pc=552          APPLY 2
    pc=553          MAKEBLOCK 10 1
    pc=554          RETURN 3
    pc=555  L48:    ACC 0
    pc=556          GETFIELD 1
    pc=557          PUSH
    pc=558          ACC 1
    pc=559          GETFIELD 0
    pc=560          PUSH
    pc=561          ACC 3
    pc=562          PUSH
    pc=563          ACC 2
    pc=564          PUSH
    pc=565          OFFSETCLOSURE 0
    pc=566          APPLY 2
    pc=567          PUSH
    pc=568          ACC 1
    pc=569          MAKEBLOCK 11 2
    pc=570          RETURN 4
    pc=571  L49:    ACC 0
    pc=572          GETFIELD 1
    pc=573          PUSH
    pc=574          ACC 1
    pc=575          GETFIELD 0
    pc=576          PUSH
    pc=577          ACC 3
    pc=578          PUSH
    pc=579          ACC 2
    pc=580          PUSH
    pc=581          OFFSETCLOSURE 0
    pc=582          APPLY 2
    pc=583          PUSH
    pc=584          ACC 1
    pc=585          MAKEBLOCK 12 2
    pc=586          RETURN 4
    pc=587  L50:    ACC 0
    pc=588          GETFIELD 2
    pc=589          PUSH
    pc=590          ACC 1
    pc=591          GETFIELD 1
    pc=592          PUSH
    pc=593          ACC 2
    pc=594          GETFIELD 0
    pc=595          PUSH
    pc=596          ACC 4
    pc=597          PUSH
    pc=598          ACC 3
    pc=599          PUSH
    pc=600          OFFSETCLOSURE 0
    pc=601          APPLY 2
    pc=602          PUSH
    pc=603          ACC 2
    pc=604          PUSH
    pc=605          ACC 2
    pc=606          MAKEBLOCK 13 3
    pc=607          RETURN 5
    pc=608  L51:    ACC 0
    pc=609          GETFIELD 2
    pc=610          PUSH
    pc=611          ACC 1
    pc=612          GETFIELD 1
    pc=613          PUSH
    pc=614          ACC 2
    pc=615          GETFIELD 0
    pc=616          PUSH
    pc=617          ACC 4
    pc=618          PUSH
    pc=619          ACC 3
    pc=620          PUSH
    pc=621          OFFSETCLOSURE 0
    pc=622          APPLY 2
    pc=623          PUSH
    pc=624          ACC 2
    pc=625          PUSH
    pc=626          ACC 2
    pc=627          MAKEBLOCK 14 3
    pc=628          RETURN 5
    pc=629  L52:    ACC 0
    pc=630          GETFIELD 0
    pc=631          PUSH
    pc=632          ACC 2
    pc=633          PUSH
    pc=634          ACC 1
    pc=635          PUSH
    pc=636          OFFSETCLOSURE 0
    pc=637          APPLY 2
    pc=638          MAKEBLOCK 15 1
    pc=639          RETURN 3
    pc=640  L53:    ACC 0
    pc=641          GETFIELD 0
    pc=642          PUSH
    pc=643          ACC 2
    pc=644          PUSH
    pc=645          ACC 1
    pc=646          PUSH
    pc=647          OFFSETCLOSURE 0
    pc=648          APPLY 2
    pc=649          MAKEBLOCK 16 1
    pc=650          RETURN 3
    pc=651  L54:    ACC 0
    pc=652          GETFIELD 1
    pc=653          PUSH
    pc=654          ACC 1
    pc=655          GETFIELD 0
    pc=656          PUSH
    pc=657          ACC 3
    pc=658          PUSH
    pc=659          ACC 2
    pc=660          PUSH
    pc=661          OFFSETCLOSURE 0
    pc=662          APPLY 2
    pc=663          PUSH
    pc=664          ACC 1
    pc=665          MAKEBLOCK 17 2
    pc=666          RETURN 4
    pc=667  L55:    ACC 0
    pc=668          GETFIELD 1
    pc=669          PUSH
    pc=670          ACC 1
    pc=671          GETFIELD 0
    pc=672          PUSH
    pc=673          ACC 3
    pc=674          PUSH
    pc=675          ACC 2
    pc=676          PUSH
    pc=677          OFFSETCLOSURE 0
    pc=678          APPLY 2
    pc=679          PUSH
    pc=680          ACC 1
    pc=681          MAKEBLOCK 18 2
    pc=682          RETURN 4
    pc=683  L56:    ACC 0
    pc=684          GETFIELD 0
    pc=685          PUSH
    pc=686          ACC 2
    pc=687          PUSH
    pc=688          ACC 1
    pc=689          PUSH
    pc=690          OFFSETCLOSURE 0
    pc=691          APPLY 2
    pc=692          MAKEBLOCK 19 1
    pc=693          RETURN 3
    pc=694  L57:    ACC 0
    pc=695          GETFIELD 2
    pc=696          PUSH
    pc=697          ACC 1
    pc=698          GETFIELD 1
    pc=699          PUSH
    pc=700          ACC 2
    pc=701          GETFIELD 0
    pc=702          PUSH
    pc=703          ACC 4
    pc=704          PUSH
    pc=705          ACC 3
    pc=706          PUSH
    pc=707          OFFSETCLOSURE 0
    pc=708          APPLY 2
    pc=709          PUSH
    pc=710          ACC 2
    pc=711          PUSH
    pc=712          ACC 2
    pc=713          MAKEBLOCK 20 3
    pc=714          RETURN 5
    pc=715  L58:    ACC 0
    pc=716          GETFIELD 1
    pc=717          PUSH
    pc=718          ACC 1
    pc=719          GETFIELD 0
    pc=720          PUSH
    pc=721          ACC 3
    pc=722          PUSH
    pc=723          ACC 2
    pc=724          PUSH
    pc=725          OFFSETCLOSURE 0
    pc=726          APPLY 2
    pc=727          PUSH
    pc=728          ACC 1
    pc=729          MAKEBLOCK 21 2
    pc=730          RETURN 4
    pc=731  L59:    ACC 0
    pc=732          GETFIELD 0
    pc=733          PUSH
    pc=734          ACC 2
    pc=735          PUSH
    pc=736          ACC 1
    pc=737          PUSH
    pc=738          OFFSETCLOSURE 0
    pc=739          APPLY 2
    pc=740          MAKEBLOCK 22 1
    pc=741          RETURN 3
    pc=742  L60:    ACC 0
    pc=743          GETFIELD 1
    pc=744          PUSH
    pc=745          ACC 1
    pc=746          GETFIELD 0
    pc=747          PUSH
    pc=748          ACC 3
    pc=749          PUSH
    pc=750          ACC 2
    pc=751          PUSH
    pc=752          OFFSETCLOSURE 0
    pc=753          APPLY 2
    pc=754          PUSH
    pc=755          ACC 1
    pc=756          MAKEBLOCK 23 2
    pc=757          RETURN 4
    pc=758  L61:    ACC 0
    pc=759          GETFIELD 2
    pc=760          PUSH
    pc=761          ACC 1
    pc=762          GETFIELD 1
    pc=763          PUSH
    pc=764          ACC 2
    pc=765          GETFIELD 0
    pc=766          PUSH
    pc=767          ACC 4
    pc=768          PUSH
    pc=769          ACC 3
    pc=770          PUSH
    pc=771          OFFSETCLOSURE 0
    pc=772          APPLY 2
    pc=773          PUSH
    pc=774          ACC 2
    pc=775          PUSH
    pc=776          ACC 2
    pc=777          MAKEBLOCK 24 3
    pc=778          RETURN 5

    pc=779  L62:    CLOSUREREC 0 [ L1 ]
    pc=780          CLOSUREREC 0 [ L18 ]
    pc=781          CLOSUREREC 0 [ L35 ]
    pc=782          ACC 0
    pc=783          PUSH
    pc=784          ACC 3
    pc=785          PUSH
    pc=786          ACC 3
    pc=787          MAKEBLOCK 0 3
    pc=788          POP 3
    pc=789          SETGLOBAL {CamlinternalFormatBasics}
    pc=790          BRANCH L72

    pc=791  L63:    CONSTINT -1
    pc=792          PUSH
    pc=793          ACC 1
    pc=794          PUSH
    pc=795          ENVACC 1
    pc=796          APPLY 2
    pc=797          CONSTINT 0
    pc=798          RETURN 1

    pc=799  L64:    CONSTINT 1
    pc=800          PUSH
    pc=801          ACC 1
    pc=802          PUSH
    pc=803          ENVACC 1
    pc=804          APPLY 2
    pc=805          CONSTINT 0
    pc=806          RETURN 1

    pc=807          RESTART
    pc=808  L65:    GRAB 1
    pc=809          ACC 0
    pc=810          GETFIELD 0
    pc=811          PUSH
    pc=812          ACC 2
    pc=813          PUSH
    pc=814          ACC 1
    pc=815          BINAPP ADD
    pc=816          PUSH
    pc=817          ACC 2
    pc=818          SETFIELD 0
    pc=819          ACC 0
    pc=820          RETURN 3

    pc=821          RESTART
    pc=822  L66:    GRAB 2
    pc=823          ACC 0
    pc=824          GETFIELD 0
    pc=825          PUSH
    pc=826          ACC 2
    pc=827          PUSH
    pc=828          ACC 1
    pc=829          COMPARE EQ
    pc=830          BRANCHIFNOT L67
    pc=831          ACC 3
    pc=832          PUSH
    pc=833          ACC 2
    pc=834          SETFIELD 0
    pc=835          CONSTINT 1
    pc=836          RETURN 4
    pc=837  L67:    CONSTINT 0
    pc=838          RETURN 4

    pc=839          RESTART
    pc=840  L68:    GRAB 1
    pc=841          ACC 0
    pc=842          GETFIELD 0
    pc=843          PUSH
    pc=844          ACC 2
    pc=845          PUSH
    pc=846          ACC 2
    pc=847          SETFIELD 0
    pc=848          ACC 0
    pc=849          RETURN 3

    pc=850          RESTART
    pc=851  L69:    GRAB 1
    pc=852          ACC 1
    pc=853          PUSH
    pc=854          ACC 1
    pc=855          SETFIELD 0
    pc=856          RETURN 2

    pc=857  L70:    ACC 0
    pc=858          GETFIELD 0
    pc=859          RETURN 1

    pc=860  L71:    ACC 0
    pc=861          MAKEBLOCK 0 1
    pc=862          RETURN 1

    pc=863  L72:    CLOSURE 0 L71
    pc=864          PUSH
    pc=865          CLOSURE 0 L70
    pc=866          PUSH
    pc=867          CLOSURE 0 L69
    pc=868          PUSH
    pc=869          CLOSURE 0 L68
    pc=870          PUSH
    pc=871          CLOSURE 0 L66
    pc=872          PUSH
    pc=873          CLOSURE 0 L65
    pc=874          PUSH
    pc=875          ACC 0
    pc=876          CLOSURE 1 L64
    pc=877          PUSH
    pc=878          ACC 1
    pc=879          CLOSURE 1 L63
    pc=880          PUSH
    pc=881          ACC 0
    pc=882          PUSH
    pc=883          ACC 2
    pc=884          PUSH
    pc=885          ACC 4
    pc=886          PUSH
    pc=887          ACC 6
    pc=888          PUSH
    pc=889          ACC 8
    pc=890          PUSH
    pc=891          ACC 10
    pc=892          PUSH
    pc=893          ACC 12
    pc=894          PUSH
    pc=895          ACC 14
    pc=896          MAKEBLOCK 0 8
    pc=897          POP 8
    pc=898          SETGLOBAL {CamlinternalAtomic}
    pc=899          BRANCH L209

    pc=900          RESTART
    pc=901  L73:    GRAB 1
    pc=902          ACC 0
    pc=903          BRANCHIFNOT L74
    pc=904          ACC 0
    pc=905          GETFIELD 1
    pc=906          PUSH
    pc=907          ACC 1
    pc=908          GETFIELD 0
    pc=909          PUSH
    pc=910          ACC 3
    pc=911          PUSH
    pc=912          ACC 2
    pc=913          PUSH
    pc=914          OFFSETCLOSURE 0
    pc=915          APPLY 2
    pc=916          PUSH
    pc=917          ACC 1
    pc=918          MAKEBLOCK 0 2
    pc=919          RETURN 4
    pc=920  L74:    ACC 1
    pc=921          RETURN 2

    pc=922          RESTART
    pc=923  L75:    GRAB 3
    pc=924          ACC 3
    pc=925          COMPBRANCH LT 0 L76
    pc=926          CONSTINT 0
    pc=927          RETURN 4
    pc=928  L76:    ACC 3
    pc=929          PUSH
    pc=930          ACC 3
    pc=931          PUSH
    pc=932          ACC 3
    pc=933          PUSH
    pc=934          ACC 3
    pc=935          C_CALL 4 "caml_ml_input"
    pc=936          PUSH
    pc=937          ACC 0
    pc=938          COMPBRANCH NEQ 0 L77
    pc=939          ENVACC 1
    pc=940          RAISE
    pc=941  L77:    ACC 0
    pc=942          PUSH
    pc=943          ACC 5
    pc=944          BINAPP SUB
    pc=945          PUSH
    pc=946          ACC 1
    pc=947          PUSH
    pc=948          ACC 5
    pc=949          BINAPP ADD
    pc=950          PUSH
    pc=951          ACC 4
    pc=952          PUSH
    pc=953          ACC 4
    pc=954          PUSH
    pc=955          OFFSETCLOSURE 0
    pc=956          APPTERM 4 9

    pc=957  L78:    CONSTINT 0
    pc=958          PUSH
    pc=959          CONSTINT 1
    pc=960          PUSH
    pc=961          ENVACC 2
    pc=962          PUSH
    pc=963          GETGLOBAL {CamlinternalAtomic}
    pc=964          GETFIELD 4
    pc=965          APPLY 3
    pc=966          BRANCHIFNOT L79
    pc=967          CONSTINT 0
    pc=968          PUSH
    pc=969          ENVACC 1
    pc=970          APPLY 1
    pc=971  L79:    CONSTINT 0
    pc=972          PUSH
    pc=973          ENVACC 3
    pc=974          APPTERM 1 2

    pc=975  L80:    CONSTINT 1
    pc=976          PUSH
    pc=977          GETGLOBAL {CamlinternalAtomic}
    pc=978          GETFIELD 0
    pc=979          APPLY 1
    pc=980          PUSH
    pc=981          ENVACC 1
    pc=982          PUSH
    pc=983          GETGLOBAL {CamlinternalAtomic}
    pc=984          GETFIELD 1
    pc=985          APPLY 1
    pc=986          PUSH
    pc=987          ACC 0
    pc=988          PUSH
    pc=989          ACC 2
    pc=990          PUSH
    pc=991          ACC 4
    pc=992          CLOSURE 3 L78
    pc=993          PUSH
    pc=994          ACC 0
    pc=995          PUSH
    pc=996          ACC 2
    pc=997          PUSH
    pc=998          ENVACC 1
    pc=999          PUSH
    pc=1000         GETGLOBAL {CamlinternalAtomic}
    pc=1001         GETFIELD 4
    pc=1002         APPLY 3
    pc=1003         PUSH
    pc=1004         ACC 0
    pc=1005         UNAPP NOT
    pc=1006         BRANCHIFNOT L81
    pc=1007         ACC 4
    pc=1008         PUSH
    pc=1009         OFFSETCLOSURE 0
    pc=1010         APPTERM 1 6
    pc=1011 L81:    RETURN 5

    pc=1012 L82:    ACC 0
    pc=1013         C_CALL 1 "caml_ml_flush"
    pc=1014         RETURN 1

    pc=1015         RESTART
    pc=1016 L83:    GRAB 1
    pc=1017         ACC 1
    pc=1018         PUSH
    pc=1019         ACC 1
    pc=1020         C_CALL 2 "caml_ml_output_char"
    pc=1021         RETURN 2

    pc=1022         RESTART
    pc=1023 L84:    GRAB 1
    pc=1024         ACC 1
    pc=1025         PUSH
    pc=1026         ACC 1
    pc=1027         C_CALL 2 "caml_ml_output_char"
    pc=1028         RETURN 2

    pc=1029         RESTART
    pc=1030 L85:    GRAB 1
    pc=1031         ACC 1
    pc=1032         PUSH
    pc=1033         ACC 1
    pc=1034         C_CALL 2 "caml_ml_output_int"
    pc=1035         RETURN 2

    pc=1036         RESTART
    pc=1037 L86:    GRAB 1
    pc=1038         ACC 1
    pc=1039         PUSH
    pc=1040         ACC 1
    pc=1041         C_CALL 2 "caml_ml_seek_out"
    pc=1042         RETURN 2

    pc=1043 L87:    ACC 0
    pc=1044         C_CALL 1 "caml_ml_pos_out"
    pc=1045         RETURN 1

    pc=1046 L88:    ACC 0
    pc=1047         C_CALL 1 "caml_ml_channel_size"
    pc=1048         RETURN 1

    pc=1049         RESTART
    pc=1050 L89:    GRAB 1
    pc=1051         ACC 1
    pc=1052         PUSH
    pc=1053         ACC 1
    pc=1054         C_CALL 2 "caml_ml_set_binary_mode"
    pc=1055         RETURN 2

    pc=1056 L90:    ACC 0
    pc=1057         C_CALL 1 "caml_ml_input_char"
    pc=1058         RETURN 1

    pc=1059 L91:    ACC 0
    pc=1060         C_CALL 1 "caml_ml_input_char"
    pc=1061         RETURN 1

    pc=1062 L92:    ACC 0
    pc=1063         C_CALL 1 "caml_ml_input_int"
    pc=1064         RETURN 1

    pc=1065 L93:    ACC 0
    pc=1066         C_CALL 1 "caml_input_value"
    pc=1067         RETURN 1

    pc=1068         RESTART
    pc=1069 L94:    GRAB 1
    pc=1070         ACC 1
    pc=1071         PUSH
    pc=1072         ACC 1
    pc=1073         C_CALL 2 "caml_ml_seek_in"
    pc=1074         RETURN 2

    pc=1075 L95:    ACC 0
    pc=1076         C_CALL 1 "caml_ml_pos_in"
    pc=1077         RETURN 1

    pc=1078 L96:    ACC 0
    pc=1079         C_CALL 1 "caml_ml_channel_size"
    pc=1080         RETURN 1

    pc=1081 L97:    ACC 0
    pc=1082         C_CALL 1 "caml_ml_close_channel"
    pc=1083         RETURN 1

    pc=1084         RESTART
    pc=1085 L98:    GRAB 1
    pc=1086         ACC 1
    pc=1087         PUSH
    pc=1088         ACC 1
    pc=1089         C_CALL 2 "caml_ml_set_binary_mode"
    pc=1090         RETURN 2

    pc=1091         RESTART
    pc=1092 L99:    GRAB 1
    pc=1093         ACC 1
    pc=1094         PUSH
    pc=1095         ACC 1
    pc=1096         C_CALL 2 "caml_ml_seek_out_64"
    pc=1097         RETURN 2

    pc=1098 L100:   ACC 0
    pc=1099         C_CALL 1 "caml_ml_pos_out_64"
    pc=1100         RETURN 1

    pc=1101 L101:   ACC 0
    pc=1102         C_CALL 1 "caml_ml_channel_size_64"
    pc=1103         RETURN 1

    pc=1104         RESTART
    pc=1105 L102:   GRAB 1
    pc=1106         ACC 1
    pc=1107         PUSH
    pc=1108         ACC 1
    pc=1109         C_CALL 2 "caml_ml_seek_in_64"
    pc=1110         RETURN 2

    pc=1111 L103:   ACC 0
    pc=1112         C_CALL 1 "caml_ml_pos_in_64"
    pc=1113         RETURN 1

    pc=1114 L104:   ACC 0
    pc=1115         C_CALL 1 "caml_ml_channel_size_64"
    pc=1116         RETURN 1

    pc=1117 L105:   ACC 0
    pc=1118         C_CALL 1 "caml_gc_major"
    pc=1119         RETURN 1

    pc=1120 L106:   CONSTINT 0
    pc=1121         PUSH
    pc=1122         ENVACC 1
    pc=1123         APPLY 1
    pc=1124         ACC 0
    pc=1125         C_CALL 1 "caml_sys_exit"
    pc=1126         RETURN 1

    pc=1127 L107:   CONSTINT 0
    pc=1128         PUSH
    pc=1129         ENVACC 1
    pc=1130         PUSH
    pc=1131         GETGLOBAL {CamlinternalAtomic}
    pc=1132         GETFIELD 1
    pc=1133         APPLY 1
    pc=1134         APPTERM 1 2

    pc=1135         RESTART
    pc=1136 L108:   GRAB 1
    pc=1137         ACC 1
    pc=1138         GETFIELD 1
    pc=1139         PUSH
    pc=1140         ACC 2
    pc=1141         GETFIELD 0
    pc=1142         PUSH
    pc=1143         ACC 2
    pc=1144         GETFIELD 1
    pc=1145         PUSH
    pc=1146         ACC 3
    pc=1147         GETFIELD 0
    pc=1148         PUSH
    pc=1149         ACC 3
    pc=1150         PUSH
    pc=1151         GETGLOBAL "%,"
    pc=1152         PUSH
    pc=1153         ENVACC 1
    pc=1154         APPLY 2
    pc=1155         PUSH
    pc=1156         ACC 2
    pc=1157         PUSH
    pc=1158         ENVACC 1
    pc=1159         APPLY 2
    pc=1160         PUSH
    pc=1161         ACC 3
    pc=1162         PUSH
    pc=1163         ACC 2
    pc=1164         PUSH
    pc=1165         GETGLOBAL {CamlinternalFormatBasics}
    pc=1166         GETFIELD 2
    pc=1167         APPLY 2
    pc=1168         MAKEBLOCK 0 2
    pc=1169         RETURN 6

    pc=1170 L109:   ACC 0
    pc=1171         GETFIELD 1
    pc=1172         PUSH
    pc=1173         ACC 0
    pc=1174         RETURN 2

    pc=1175 L110:   CONSTINT 0
    pc=1176         PUSH
    pc=1177         ENVACC 2
    pc=1178         APPLY 1
    pc=1179         PUSH
    pc=1180         ENVACC 1
    pc=1181         APPTERM 1 2

    pc=1182 L111:   CONSTINT 0
    pc=1183         PUSH
    pc=1184         ENVACC 1
    pc=1185         APPLY 1
    pc=1186         C_CALL 1 "caml_float_of_string"
    pc=1187         RETURN 1

    pc=1188 L112:   CONSTINT 0
    pc=1189         PUSH
    pc=1190         ENVACC 2
    pc=1191         APPLY 1
    pc=1192         PUSH
    pc=1193         ENVACC 1
    pc=1194         APPTERM 1 2

    pc=1195 L113:   CONSTINT 0
    pc=1196         PUSH
    pc=1197         ENVACC 1
    pc=1198         APPLY 1
    pc=1199         C_CALL 1 "caml_int_of_string"
    pc=1200         RETURN 1

    pc=1201 L114:   ENVACC 2
    pc=1202         C_CALL 1 "caml_ml_flush"
    pc=1203         ENVACC 1
    pc=1204         PUSH
    pc=1205         ENVACC 3
    pc=1206         APPTERM 1 2

    pc=1207 L115:   CONSTINT 10
    pc=1208         PUSH
    pc=1209         ENVACC 1
    pc=1210         C_CALL 2 "caml_ml_output_char"
    pc=1211         ENVACC 1
    pc=1212         C_CALL 1 "caml_ml_flush"
    pc=1213         RETURN 1

    pc=1214 L116:   ACC 0
    pc=1215         PUSH
    pc=1216         ENVACC 1
    pc=1217         PUSH
    pc=1218         ENVACC 2
    pc=1219         APPLY 2
    pc=1220         CONSTINT 10
    pc=1221         PUSH
    pc=1222         ENVACC 1
    pc=1223         C_CALL 2 "caml_ml_output_char"
    pc=1224         ENVACC 1
    pc=1225         C_CALL 1 "caml_ml_flush"
    pc=1226         RETURN 1

    pc=1227 L117:   ACC 0
    pc=1228         PUSH
    pc=1229         ENVACC 1
    pc=1230         APPLY 1
    pc=1231         PUSH
    pc=1232         ENVACC 2
    pc=1233         PUSH
    pc=1234         ENVACC 3
    pc=1235         APPTERM 2 3

    pc=1236 L118:   ACC 0
    pc=1237         PUSH
    pc=1238         ENVACC 1
    pc=1239         APPLY 1
    pc=1240         PUSH
    pc=1241         ENVACC 2
    pc=1242         PUSH
    pc=1243         ENVACC 3
    pc=1244         APPTERM 2 3

    pc=1245 L119:   ACC 0
    pc=1246         PUSH
    pc=1247         ENVACC 1
    pc=1248         PUSH
    pc=1249         ENVACC 2
    pc=1250         APPTERM 2 3

    pc=1251 L120:   ACC 0
    pc=1252         PUSH
    pc=1253         ENVACC 1
    pc=1254         PUSH
    pc=1255         ENVACC 2
    pc=1256         APPTERM 2 3

    pc=1257 L121:   ACC 0
    pc=1258         PUSH
    pc=1259         ENVACC 1
    pc=1260         C_CALL 2 "caml_ml_output_char"
    pc=1261         RETURN 1

    pc=1262 L122:   CONSTINT 10
    pc=1263         PUSH
    pc=1264         ENVACC 1
    pc=1265         C_CALL 2 "caml_ml_output_char"
    pc=1266         ENVACC 1
    pc=1267         C_CALL 1 "caml_ml_flush"
    pc=1268         RETURN 1

    pc=1269 L123:   ACC 0
    pc=1270         PUSH
    pc=1271         ENVACC 1
    pc=1272         PUSH
    pc=1273         ENVACC 2
    pc=1274         APPLY 2
    pc=1275         CONSTINT 10
    pc=1276         PUSH
    pc=1277         ENVACC 1
    pc=1278         C_CALL 2 "caml_ml_output_char"
    pc=1279         ENVACC 1
    pc=1280         C_CALL 1 "caml_ml_flush"
    pc=1281         RETURN 1

    pc=1282 L124:   ACC 0
    pc=1283         PUSH
    pc=1284         ENVACC 1
    pc=1285         APPLY 1
    pc=1286         PUSH
    pc=1287         ENVACC 2
    pc=1288         PUSH
    pc=1289         ENVACC 3
    pc=1290         APPTERM 2 3

    pc=1291 L125:   ACC 0
    pc=1292         PUSH
    pc=1293         ENVACC 1
    pc=1294         APPLY 1
    pc=1295         PUSH
    pc=1296         ENVACC 2
    pc=1297         PUSH
    pc=1298         ENVACC 3
    pc=1299         APPTERM 2 3

    pc=1300 L126:   ACC 0
    pc=1301         PUSH
    pc=1302         ENVACC 1
    pc=1303         PUSH
    pc=1304         ENVACC 2
    pc=1305         APPTERM 2 3

    pc=1306 L127:   ACC 0
    pc=1307         PUSH
    pc=1308         ENVACC 1
    pc=1309         PUSH
    pc=1310         ENVACC 2
    pc=1311         APPTERM 2 3

    pc=1312 L128:   ACC 0
    pc=1313         PUSH
    pc=1314         ENVACC 1
    pc=1315         C_CALL 2 "caml_ml_output_char"
    pc=1316         RETURN 1

    pc=1317 L129:   PUSHTRAP L130
    pc=1318         ACC 4
    pc=1319         C_CALL 1 "caml_ml_close_channel"
    pc=1320         POPTRAP
    pc=1321         RETURN 1
    pc=1322 L130:   PUSH
    pc=1323         CONSTINT 0
    pc=1324         RETURN 2

    pc=1325         RESTART
    pc=1326 L131:   GRAB 2
    pc=1327         ACC 2
    pc=1328         BRANCHIFNOT L132
    pc=1329         ACC 2
    pc=1330         GETFIELD 1
    pc=1331         PUSH
    pc=1332         ACC 3
    pc=1333         GETFIELD 0
    pc=1334         PUSH
    pc=1335         ACC 0
    pc=1336         C_CALL 1 "caml_ml_bytes_length"
    pc=1337         PUSH
    pc=1338         ACC 0
    pc=1339         PUSH
    pc=1340         ACC 1
    pc=1341         PUSH
    pc=1342         ACC 6
    pc=1343         BINAPP SUB
    pc=1344         PUSH
    pc=1345         ACC 5
    pc=1346         PUSH
    pc=1347         CONSTINT 0
    pc=1348         PUSH
    pc=1349         ACC 5
    pc=1350         C_CALL 5 "caml_blit_bytes"
    pc=1351         ACC 2
    pc=1352         PUSH
    pc=1353         ACC 1
    pc=1354         PUSH
    pc=1355         ACC 6
    pc=1356         BINAPP SUB
    pc=1357         PUSH
    pc=1358         ACC 5
    pc=1359         PUSH
    pc=1360         OFFSETCLOSURE 0
    pc=1361         APPTERM 3 9
    pc=1362 L132:   ACC 0
    pc=1363         RETURN 3

    pc=1364         RESTART
    pc=1365 L133:   GRAB 1
    pc=1366         ENVACC 2
    pc=1367         C_CALL 1 "caml_ml_input_scan_line"
    pc=1368         PUSH
    pc=1369         ACC 0
    pc=1370         COMPBRANCH NEQ 0 L135
    pc=1371         ACC 1
    pc=1372         BRANCHIFNOT L134
    pc=1373         ACC 1
    pc=1374         PUSH
    pc=1375         ACC 3
    pc=1376         PUSH
    pc=1377         ACC 4
    pc=1378         C_CALL 1 "caml_create_bytes"
    pc=1379         PUSH
    pc=1380         ENVACC 3
    pc=1381         APPTERM 3 6
    pc=1382 L134:   ENVACC 1
    pc=1383         RAISE
    pc=1384 L135:   ACC 0
    pc=1385         COMPBRANCH GE 0 L137
    pc=1386         ACC 0
    pc=1387         UNAPP OFFSET -1
    pc=1388         C_CALL 1 "caml_create_bytes"
    pc=1389         PUSH
    pc=1390         ACC 1
    pc=1391         UNAPP OFFSET -1
    pc=1392         PUSH
    pc=1393         CONSTINT 0
    pc=1394         PUSH
    pc=1395         ACC 2
    pc=1396         PUSH
    pc=1397         ENVACC 2
    pc=1398         C_CALL 4 "caml_ml_input"
    pc=1399         CONSTINT 0
    pc=1400         ENVACC 2
    pc=1401         C_CALL 1 "caml_ml_input_char"
    pc=1402         CONSTINT 0
    pc=1403         ACC 2
    pc=1404         BRANCHIFNOT L136
    pc=1405         ACC 1
    pc=1406         PUSH
    pc=1407         ACC 4
    pc=1408         BINAPP ADD
    pc=1409         UNAPP OFFSET -1
    pc=1410         PUSH
    pc=1411         ACC 3
    pc=1412         PUSH
    pc=1413         ACC 2
    pc=1414         MAKEBLOCK 0 2
    pc=1415         PUSH
    pc=1416         ACC 1
    pc=1417         PUSH
    pc=1418         ACC 2
    pc=1419         C_CALL 1 "caml_create_bytes"
    pc=1420         PUSH
    pc=1421         ENVACC 3
    pc=1422         APPTERM 3 8
    pc=1423 L136:   ACC 0
    pc=1424         RETURN 4
    pc=1425 L137:   ACC 0
    pc=1426         UNAPP NEG
    pc=1427         C_CALL 1 "caml_create_bytes"
    pc=1428         PUSH
    pc=1429         ACC 1
    pc=1430         UNAPP NEG
    pc=1431         PUSH
    pc=1432         CONSTINT 0
    pc=1433         PUSH
    pc=1434         ACC 2
    pc=1435         PUSH
    pc=1436         ENVACC 2
    pc=1437         C_CALL 4 "caml_ml_input"
    pc=1438         CONSTINT 0
    pc=1439         ACC 1
    pc=1440         PUSH
    pc=1441         ACC 4
    pc=1442         BINAPP SUB
    pc=1443         PUSH
    pc=1444         ACC 3
    pc=1445         PUSH
    pc=1446         ACC 2
    pc=1447         MAKEBLOCK 0 2
    pc=1448         PUSH
    pc=1449         OFFSETCLOSURE 0
    pc=1450         APPTERM 2 6

    pc=1451 L138:   CLOSUREREC 0 [ L131 ]
    pc=1452         ACC 0
    pc=1453         PUSH
    pc=1454         ACC 2
    pc=1455         PUSH
    pc=1456         ENVACC 1
    pc=1457         CLOSUREREC 3 [ L133 ]
    pc=1458         CONSTINT 0
    pc=1459         PUSH
    pc=1460         CONSTINT 0
    pc=1461         PUSH
    pc=1462         ACC 2
    pc=1463         APPLY 2
    pc=1464         C_CALL 1 "caml_string_of_bytes"
    pc=1465         RETURN 3

    pc=1466         RESTART
    pc=1467 L139:   GRAB 1
    pc=1468         ACC 1
    pc=1469         C_CALL 1 "caml_create_bytes"
    pc=1470         PUSH
    pc=1471         PUSH_RETADDR L140
    pc=1472         ACC 5
    pc=1473         PUSH
    pc=1474         CONSTINT 0
    pc=1475         PUSH
    pc=1476         ACC 5
    pc=1477         PUSH
    pc=1478         ACC 7
    pc=1479         PUSH
    pc=1480         ENVACC 1
    pc=1481         APPLY 4
    pc=1482 L140:   ACC 0
    pc=1483         C_CALL 1 "caml_string_of_bytes"
    pc=1484         RETURN 3

    pc=1485         RESTART
    pc=1486 L141:   GRAB 3
    pc=1487         ACC 2
    pc=1488         COMPBRANCH GT 0 L142
    pc=1489         ACC 3
    pc=1490         COMPBRANCH GT 0 L142
    pc=1491         ACC 3
    pc=1492         PUSH
    pc=1493         ACC 2
    pc=1494         C_CALL 1 "caml_ml_bytes_length"
    pc=1495         BINAPP SUB
    pc=1496         PUSH
    pc=1497         ACC 3
    pc=1498         COMPARE GT
    pc=1499         BRANCHIFNOT L143
    pc=1500 L142:   GETGLOBAL "really_input"
    pc=1501         PUSH
    pc=1502         ENVACC 1
    pc=1503         APPTERM 1 5
    pc=1504 L143:   ACC 3
    pc=1505         PUSH
    pc=1506         ACC 3
    pc=1507         PUSH
    pc=1508         ACC 3
    pc=1509         PUSH
    pc=1510         ACC 3
    pc=1511         PUSH
    pc=1512         ENVACC 2
    pc=1513         APPTERM 4 8

    pc=1514         RESTART
    pc=1515 L144:   GRAB 3
    pc=1516         ACC 2
    pc=1517         COMPBRANCH GT 0 L145
    pc=1518         ACC 3
    pc=1519         COMPBRANCH GT 0 L145
    pc=1520         ACC 3
    pc=1521         PUSH
    pc=1522         ACC 2
    pc=1523         C_CALL 1 "caml_ml_bytes_length"
    pc=1524         BINAPP SUB
    pc=1525         PUSH
    pc=1526         ACC 3
    pc=1527         COMPARE GT
    pc=1528         BRANCHIFNOT L146
    pc=1529 L145:   GETGLOBAL "input"
    pc=1530         PUSH
    pc=1531         ENVACC 1
    pc=1532         APPTERM 1 5
    pc=1533 L146:   ACC 3
    pc=1534         PUSH
    pc=1535         ACC 3
    pc=1536         PUSH
    pc=1537         ACC 3
    pc=1538         PUSH
    pc=1539         ACC 3
    pc=1540         C_CALL 4 "caml_ml_input"
    pc=1541         RETURN 4

    pc=1542 L147:   ACC 0
    pc=1543         PUSH
    pc=1544         CONSTINT 0
    pc=1545         PUSH
    pc=1546         GETGLOBAL [0| 0; [0| 6; 0 ] ]
    pc=1547         PUSH
    pc=1548         ENVACC 1
    pc=1549         APPTERM 3 4

    pc=1550 L148:   ACC 0
    pc=1551         PUSH
    pc=1552         CONSTINT 0
    pc=1553         PUSH
    pc=1554         GETGLOBAL [0| 0; [0| 7; 0 ] ]
    pc=1555         PUSH
    pc=1556         ENVACC 1
    pc=1557         APPTERM 3 4

    pc=1558         RESTART
    pc=1559 L149:   GRAB 2
    pc=1560         ACC 1
    pc=1561         PUSH
    pc=1562         ACC 1
    pc=1563         PUSH
    pc=1564         ACC 4
    pc=1565         C_CALL 3 "caml_sys_open"
    pc=1566         C_CALL 1 "caml_ml_open_descriptor_in"
    pc=1567         PUSH
    pc=1568         ACC 3
    pc=1569         PUSH
    pc=1570         ACC 1
    pc=1571         C_CALL 2 "caml_ml_set_channel_name"
    pc=1572         ACC 0
    pc=1573         RETURN 4

    pc=1574 L150:   PUSHTRAP L151
    pc=1575         ACC 4
    pc=1576         C_CALL 1 "caml_ml_flush"
    pc=1577         POPTRAP
    pc=1578         BRANCH L152
    pc=1579 L151:   PUSH
    pc=1580         CONSTINT 0
    pc=1581         POP 1
    pc=1582 L152:   PUSHTRAP L153
    pc=1583         ACC 4
    pc=1584         C_CALL 1 "caml_ml_close_channel"
    pc=1585         POPTRAP
    pc=1586         RETURN 1
    pc=1587 L153:   PUSH
    pc=1588         CONSTINT 0
    pc=1589         RETURN 2

    pc=1590 L154:   ACC 0
    pc=1591         C_CALL 1 "caml_ml_flush"
    pc=1592         ACC 0
    pc=1593         C_CALL 1 "caml_ml_close_channel"
    pc=1594         RETURN 1

    pc=1595         RESTART
    pc=1596 L155:   GRAB 1
    pc=1597         CONSTINT 0
    pc=1598         PUSH
    pc=1599         ACC 2
    pc=1600         PUSH
    pc=1601         ACC 2
    pc=1602         C_CALL 3 "caml_output_value"
    pc=1603         RETURN 2

    pc=1604         RESTART
    pc=1605 L156:   GRAB 3
    pc=1606         ACC 2
    pc=1607         COMPBRANCH GT 0 L157
    pc=1608         ACC 3
    pc=1609         COMPBRANCH GT 0 L157
    pc=1610         ACC 3
    pc=1611         PUSH
    pc=1612         ACC 2
    pc=1613         C_CALL 1 "caml_ml_string_length"
    pc=1614         BINAPP SUB
    pc=1615         PUSH
    pc=1616         ACC 3
    pc=1617         COMPARE GT
    pc=1618         BRANCHIFNOT L158
    pc=1619 L157:   GETGLOBAL "output_substring"
    pc=1620         PUSH
    pc=1621         ENVACC 1
    pc=1622         APPTERM 1 5
    pc=1623 L158:   ACC 3
    pc=1624         PUSH
    pc=1625         ACC 3
    pc=1626         PUSH
    pc=1627         ACC 3
    pc=1628         PUSH
    pc=1629         ACC 3
    pc=1630         C_CALL 4 "caml_ml_output"
    pc=1631         RETURN 4

    pc=1632         RESTART
    pc=1633 L159:   GRAB 3
    pc=1634         ACC 2
    pc=1635         COMPBRANCH GT 0 L160
    pc=1636         ACC 3
    pc=1637         COMPBRANCH GT 0 L160
    pc=1638         ACC 3
    pc=1639         PUSH
    pc=1640         ACC 2
    pc=1641         C_CALL 1 "caml_ml_bytes_length"
    pc=1642         BINAPP SUB
    pc=1643         PUSH
    pc=1644         ACC 3
    pc=1645         COMPARE GT
    pc=1646         BRANCHIFNOT L161
    pc=1647 L160:   GETGLOBAL "output"
    pc=1648         PUSH
    pc=1649         ENVACC 1
    pc=1650         APPTERM 1 5
    pc=1651 L161:   ACC 3
    pc=1652         PUSH
    pc=1653         ACC 3
    pc=1654         PUSH
    pc=1655         ACC 3
    pc=1656         PUSH
    pc=1657         ACC 3
    pc=1658         C_CALL 4 "caml_ml_output_bytes"
    pc=1659         RETURN 4

    pc=1660         RESTART
    pc=1661 L162:   GRAB 1
    pc=1662         ACC 1
    pc=1663         C_CALL 1 "caml_ml_string_length"
    pc=1664         PUSH
    pc=1665         CONSTINT 0
    pc=1666         PUSH
    pc=1667         ACC 3
    pc=1668         PUSH
    pc=1669         ACC 3
    pc=1670         C_CALL 4 "caml_ml_output"
    pc=1671         RETURN 2

    pc=1672         RESTART
    pc=1673 L163:   GRAB 1
    pc=1674         ACC 1
    pc=1675         C_CALL 1 "caml_ml_bytes_length"
    pc=1676         PUSH
    pc=1677         CONSTINT 0
    pc=1678         PUSH
    pc=1679         ACC 3
    pc=1680         PUSH
    pc=1681         ACC 3
    pc=1682         C_CALL 4 "caml_ml_output_bytes"
    pc=1683         RETURN 2

    pc=1684 L164:   ACC 0
    pc=1685         BRANCHIFNOT L169
    pc=1686         ACC 0
    pc=1687         GETFIELD 1
    pc=1688         PUSH
    pc=1689         ACC 1
    pc=1690         GETFIELD 0
    pc=1691         PUSH
    pc=1692         PUSHTRAP L165
    pc=1693         ACC 4
    pc=1694         C_CALL 1 "caml_ml_flush"
    pc=1695         POPTRAP
    pc=1696         BRANCH L168
    pc=1697 L165:   PUSH
    pc=1698         ACC 0
    pc=1699         GETFIELD 0
    pc=1700         PUSH
    pc=1701         ENVACC 1
    pc=1702         PUSH
    pc=1703         ACC 1
    pc=1704         COMPARE EQ
    pc=1705         BRANCHIFNOT L166
    pc=1706         CONSTINT 0
    pc=1707         BRANCH L167
    pc=1708 L166:   ACC 1
    pc=1709         RERAISE
    pc=1710 L167:   POP 2
    pc=1711 L168:   ACC 1
    pc=1712         PUSH
    pc=1713         OFFSETCLOSURE 0
    pc=1714         APPTERM 1 4
    pc=1715 L169:   CONSTINT 0
    pc=1716         RETURN 1

    pc=1717 L170:   ENVACC 1
    pc=1718         CLOSUREREC 1 [ L164 ]
    pc=1719         CONSTINT 0
    pc=1720         C_CALL 1 "caml_ml_out_channels_list"
    pc=1721         PUSH
    pc=1722         ACC 1
    pc=1723         APPTERM 1 3

    pc=1724 L171:   ACC 0
    pc=1725         PUSH
    pc=1726         CONSTINT 438
    pc=1727         PUSH
    pc=1728         GETGLOBAL [0| 1; [0| 3; [0| 4; [0| 6; 0 ] ] ] ]
    pc=1729         PUSH
    pc=1730         ENVACC 1
    pc=1731         APPTERM 3 4

    pc=1732 L172:   ACC 0
    pc=1733         PUSH
    pc=1734         CONSTINT 438
    pc=1735         PUSH
    pc=1736         GETGLOBAL [0| 1; [0| 3; [0| 4; [0| 7; 0 ] ] ] ]
    pc=1737         PUSH
    pc=1738         ENVACC 1
    pc=1739         APPTERM 3 4

    pc=1740         RESTART
    pc=1741 L173:   GRAB 2
    pc=1742         ACC 1
    pc=1743         PUSH
    pc=1744         ACC 1
    pc=1745         PUSH
    pc=1746         ACC 4
    pc=1747         C_CALL 3 "caml_sys_open"
    pc=1748         C_CALL 1 "caml_ml_open_descriptor_out"
    pc=1749         PUSH
    pc=1750         ACC 3
    pc=1751         PUSH
    pc=1752         ACC 1
    pc=1753         C_CALL 2 "caml_ml_set_channel_name"
    pc=1754         ACC 0
    pc=1755         RETURN 4

    pc=1756 L174:   PUSHTRAP L175
    pc=1757         ACC 4
    pc=1758         C_CALL 1 "caml_float_of_string"
    pc=1759         MAKEBLOCK 0 1
    pc=1760         POPTRAP
    pc=1761         RETURN 1
    pc=1762 L175:   PUSH
    pc=1763         ACC 0
    pc=1764         GETFIELD 0
    pc=1765         PUSH
    pc=1766         ENVACC 1
    pc=1767         PUSH
    pc=1768         ACC 1
    pc=1769         COMPARE EQ
    pc=1770         BRANCHIFNOT L176
    pc=1771         CONSTINT 0
    pc=1772         RETURN 3
    pc=1773 L176:   ACC 1
    pc=1774         RERAISE

    pc=1775 L177:   ACC 0
    pc=1776         PUSH
    pc=1777         GETGLOBAL "%.12g"
    pc=1778         C_CALL 2 "caml_format_float"
    pc=1779         PUSH
    pc=1780         ENVACC 1
    pc=1781         APPTERM 1 2

    pc=1782 L178:   ENVACC 3
    pc=1783         PUSH
    pc=1784         ACC 1
    pc=1785         COMPARE GE
    pc=1786         BRANCHIFNOT L179
    pc=1787         GETGLOBAL "."
    pc=1788         PUSH
    pc=1789         ENVACC 2
    pc=1790         PUSH
    pc=1791         ENVACC 1
    pc=1792         APPTERM 2 3
    pc=1793 L179:   ACC 0
    pc=1794         PUSH
    pc=1795         ENVACC 2
    pc=1796         C_CALL 2 "caml_string_get"
    pc=1797         PUSH
    pc=1798         ACC 0
    pc=1799         COMPBRANCH GT 48 L180
    pc=1800         ACC 0
    pc=1801         COMPBRANCH LE 58 L181
    pc=1802         BRANCH L182
    pc=1803 L180:   ACC 0
    pc=1804         COMPBRANCH NEQ 45 L181
    pc=1805         BRANCH L182
    pc=1806 L181:   ENVACC 2
    pc=1807         RETURN 2
    pc=1808 L182:   ACC 1
    pc=1809         UNAPP OFFSET 1
    pc=1810         PUSH
    pc=1811         OFFSETCLOSURE 0
    pc=1812         APPTERM 1 3

    pc=1813 L183:   ACC 0
    pc=1814         C_CALL 1 "caml_ml_string_length"
    pc=1815         PUSH
    pc=1816         ACC 0
    pc=1817         PUSH
    pc=1818         ACC 2
    pc=1819         PUSH
    pc=1820         ENVACC 1
    pc=1821         CLOSUREREC 3 [ L178 ]
    pc=1822         CONSTINT 0
    pc=1823         PUSH
    pc=1824         ACC 1
    pc=1825         APPTERM 1 4

    pc=1826 L184:   PUSHTRAP L185
    pc=1827         ACC 4
    pc=1828         C_CALL 1 "caml_int_of_string"
    pc=1829         MAKEBLOCK 0 1
    pc=1830         POPTRAP
    pc=1831         RETURN 1
    pc=1832 L185:   PUSH
    pc=1833         ACC 0
    pc=1834         GETFIELD 0
    pc=1835         PUSH
    pc=1836         ENVACC 1
    pc=1837         PUSH
    pc=1838         ACC 1
    pc=1839         COMPARE EQ
    pc=1840         BRANCHIFNOT L186
    pc=1841         CONSTINT 0
    pc=1842         RETURN 3
    pc=1843 L186:   ACC 1
    pc=1844         RERAISE

    pc=1845 L187:   ACC 0
    pc=1846         PUSH
    pc=1847         GETGLOBAL "%d"
    pc=1848         C_CALL 2 "caml_format_int"
    pc=1849         RETURN 1

    pc=1850 L188:   GETGLOBAL "false"
    pc=1851         PUSH
    pc=1852         ACC 1
    pc=1853         C_CALL 2 "caml_string_notequal"
    pc=1854         BRANCHIFNOT L189
    pc=1855         GETGLOBAL "true"
    pc=1856         PUSH
    pc=1857         ACC 1
    pc=1858         C_CALL 2 "caml_string_notequal"
    pc=1859         BRANCHIF L190
    pc=1860         GETGLOBAL [0| 1 ]
    pc=1861         RETURN 1
    pc=1862 L189:   GETGLOBAL [0| 0 ]
    pc=1863         RETURN 1
    pc=1864 L190:   CONSTINT 0
    pc=1865         RETURN 1

    pc=1866 L191:   GETGLOBAL "false"
    pc=1867         PUSH
    pc=1868         ACC 1
    pc=1869         C_CALL 2 "caml_string_notequal"
    pc=1870         BRANCHIFNOT L192
    pc=1871         GETGLOBAL "true"
    pc=1872         PUSH
    pc=1873         ACC 1
    pc=1874         C_CALL 2 "caml_string_notequal"
    pc=1875         BRANCHIF L193
    pc=1876         CONSTINT 1
    pc=1877         RETURN 1
    pc=1878 L192:   CONSTINT 0
    pc=1879         RETURN 1
    pc=1880 L193:   GETGLOBAL "bool_of_string"
    pc=1881         PUSH
    pc=1882         ENVACC 1
    pc=1883         APPTERM 1 2

    pc=1884 L194:   ACC 0
    pc=1885         BRANCHIFNOT L195
    pc=1886         GETGLOBAL "true"
    pc=1887         RETURN 1
    pc=1888 L195:   GETGLOBAL "false"
    pc=1889         RETURN 1

    pc=1890 L196:   ACC 0
    pc=1891         COMPBRANCH GT 0 L197
    pc=1892         ACC 0
    pc=1893         COMPBRANCH GE 255 L198
    pc=1894 L197:   GETGLOBAL "char_of_int"
    pc=1895         PUSH
    pc=1896         ENVACC 1
    pc=1897         APPTERM 1 2
    pc=1898 L198:   ACC 0
    pc=1899         RETURN 1

    pc=1900         RESTART
    pc=1901 L199:   GRAB 1
    pc=1902         ACC 0
    pc=1903         C_CALL 1 "caml_ml_string_length"
    pc=1904         PUSH
    pc=1905         ACC 2
    pc=1906         C_CALL 1 "caml_ml_string_length"
    pc=1907         PUSH
    pc=1908         ACC 0
    pc=1909         PUSH
    pc=1910         ACC 2
    pc=1911         BINAPP ADD
    pc=1912         C_CALL 1 "caml_create_bytes"
    pc=1913         PUSH
    pc=1914         ACC 2
    pc=1915         PUSH
    pc=1916         CONSTINT 0
    pc=1917         PUSH
    pc=1918         ACC 2
    pc=1919         PUSH
    pc=1920         CONSTINT 0
    pc=1921         PUSH
    pc=1922         ACC 7
    pc=1923         C_CALL 5 "caml_blit_string"
    pc=1924         ACC 1
    pc=1925         PUSH
    pc=1926         ACC 3
    pc=1927         PUSH
    pc=1928         ACC 2
    pc=1929         PUSH
    pc=1930         CONSTINT 0
    pc=1931         PUSH
    pc=1932         ACC 8
    pc=1933         C_CALL 5 "caml_blit_string"
    pc=1934         ACC 0
    pc=1935         C_CALL 1 "caml_string_of_bytes"
    pc=1936         RETURN 5

    pc=1937 L200:   CONSTINT -1
    pc=1938         PUSH
    pc=1939         ACC 1
    pc=1940         BINAPP XOR
    pc=1941         RETURN 1

    pc=1942 L201:   ACC 0
    pc=1943         COMPBRANCH GT 0 L202
    pc=1944         ACC 0
    pc=1945         RETURN 1
    pc=1946 L202:   ACC 0
    pc=1947         UNAPP NEG
    pc=1948         RETURN 1

    pc=1949         RESTART
    pc=1950 L203:   GRAB 1
    pc=1951         ACC 1
    pc=1952         PUSH
    pc=1953         ACC 1
    pc=1954         C_CALL 2 "caml_greaterequal"
    pc=1955         BRANCHIFNOT L204
    pc=1956         ACC 0
    pc=1957         RETURN 2
    pc=1958 L204:   ACC 1
    pc=1959         RETURN 2

    pc=1960         RESTART
    pc=1961 L205:   GRAB 1
    pc=1962         ACC 1
    pc=1963         PUSH
    pc=1964         ACC 1
    pc=1965         C_CALL 2 "caml_lessequal"
    pc=1966         BRANCHIFNOT L206
    pc=1967         ACC 0
    pc=1968         RETURN 2
    pc=1969 L206:   ACC 1
    pc=1970         RETURN 2

    pc=1971 L207:   ACC 0
    pc=1972         PUSH
    pc=1973         GETGLOBAL {Invalid_argument}
    pc=1974         MAKEBLOCK 0 2
    pc=1975         RAISE

    pc=1976 L208:   ACC 0
    pc=1977         PUSH
    pc=1978         GETGLOBAL {Failure}
    pc=1979         MAKEBLOCK 0 2
    pc=1980         RAISE

    pc=1981 L209:   GETGLOBAL "index out of bounds"
    pc=1982         PUSH
    pc=1983         GETGLOBAL {Invalid_argument}
    pc=1984         MAKEBLOCK 0 2
    pc=1985         PUSH
    pc=1986         GETGLOBAL "Pervasives.array_bound_error"
    pc=1987         C_CALL 2 "caml_register_named_value"
    pc=1988         PUSH
    pc=1989         CLOSURE 0 L208
    pc=1990         PUSH
    pc=1991         CLOSURE 0 L207
    pc=1992         PUSH
    pc=1993         CONSTINT 0
    pc=1994         C_CALL 1 "caml_fresh_oo_id"
    pc=1995         PUSH
    pc=1996         GETGLOBAL "Stdlib.Exit"
    pc=1997         MAKEBLOCK 248 2
    pc=1998         PUSH
    pc=1999         GETGLOBAL {Match_failure}
    pc=2000         PUSH
    pc=2001         GETGLOBAL {Assert_failure}
    pc=2002         PUSH
    pc=2003         GETGLOBAL {Invalid_argument}
    pc=2004         PUSH
    pc=2005         GETGLOBAL {Failure}
    pc=2006         PUSH
    pc=2007         GETGLOBAL {Not_found}
    pc=2008         PUSH
    pc=2009         GETGLOBAL {Out_of_memory}
    pc=2010         PUSH
    pc=2011         GETGLOBAL {Stack_overflow}
    pc=2012         PUSH
    pc=2013         GETGLOBAL {Sys_error}
    pc=2014         PUSH
    pc=2015         GETGLOBAL {End_of_file}
    pc=2016         PUSH
    pc=2017         GETGLOBAL {Division_by_zero}
    pc=2018         PUSH
    pc=2019         GETGLOBAL {Sys_blocked_io}
    pc=2020         PUSH
    pc=2021         GETGLOBAL {Undefined_recursive_module}
    pc=2022         PUSH
    pc=2023         CLOSURE 0 L205
    pc=2024         PUSH
    pc=2025         CLOSURE 0 L203
    pc=2026         PUSH
    pc=2027         CLOSURE 0 L201
    pc=2028         PUSH
    pc=2029         CLOSURE 0 L200
    pc=2030         PUSH
    pc=2031         CONSTINT 1
    pc=2032         PUSH
    pc=2033         CONSTINT -1
    pc=2034         BINAPP LSR
    pc=2035         PUSH
    pc=2036         ACC 0
    pc=2037         UNAPP OFFSET 1
    pc=2038         PUSH
    pc=2039         GETGLOBAL 9218868437227405312L
    pc=2040         C_CALL 1 "caml_int64_float_of_bits"
    pc=2041         PUSH
    pc=2042         GETGLOBAL -4503599627370496L
    pc=2043         C_CALL 1 "caml_int64_float_of_bits"
    pc=2044         PUSH
    pc=2045         GETGLOBAL 9218868437227405313L
    pc=2046         C_CALL 1 "caml_int64_float_of_bits"
    pc=2047         PUSH
    pc=2048         GETGLOBAL 9218868437227405311L
    pc=2049         C_CALL 1 "caml_int64_float_of_bits"
    pc=2050         PUSH
    pc=2051         GETGLOBAL 4503599627370496L
    pc=2052         C_CALL 1 "caml_int64_float_of_bits"
    pc=2053         PUSH
    pc=2054         GETGLOBAL 4372995238176751616L
    pc=2055         C_CALL 1 "caml_int64_float_of_bits"
    pc=2056         PUSH
    pc=2057         CLOSURE 0 L199
    pc=2058         PUSH
    pc=2059         ACC 26
    pc=2060         CLOSURE 1 L196
    pc=2061         PUSH
    pc=2062         CLOSURE 0 L194
    pc=2063         PUSH
    pc=2064         ACC 28
    pc=2065         CLOSURE 1 L191
    pc=2066         PUSH
    pc=2067         CLOSURE 0 L188
    pc=2068         PUSH
    pc=2069         CLOSURE 0 L187
    pc=2070         PUSH
    pc=2071         ACC 26
    pc=2072         CLOSURE 1 L184
    pc=2073         PUSH
    pc=2074         ACC 6
    pc=2075         CLOSURE 1 L183
    pc=2076         PUSH
    pc=2077         ACC 0
    pc=2078         CLOSURE 1 L177
    pc=2079         PUSH
    pc=2080         ACC 29
    pc=2081         CLOSURE 1 L174
    pc=2082         PUSH
    pc=2083         CLOSUREREC 0 [ L73 ]
    pc=2084         CONSTINT 0
    pc=2085         C_CALL 1 "caml_ml_open_descriptor_in"
    pc=2086         PUSH
    pc=2087         CONSTINT 1
    pc=2088         C_CALL 1 "caml_ml_open_descriptor_out"
    pc=2089         PUSH
    pc=2090         CONSTINT 2
    pc=2091         C_CALL 1 "caml_ml_open_descriptor_out"
    pc=2092         PUSH
    pc=2093         CLOSURE 0 L173
    pc=2094         PUSH
    pc=2095         ACC 0
    pc=2096         CLOSURE 1 L172
    pc=2097         PUSH
    pc=2098         ACC 1
    pc=2099         CLOSURE 1 L171
    pc=2100         PUSH
    pc=2101         ACC 33
    pc=2102         CLOSURE 1 L170
    pc=2103         PUSH
    pc=2104         CLOSURE 0 L163
    pc=2105         PUSH
    pc=2106         CLOSURE 0 L162
    pc=2107         PUSH
    pc=2108         ACC 45
    pc=2109         CLOSURE 1 L159
    pc=2110         PUSH
    pc=2111         ACC 46
    pc=2112         CLOSURE 1 L156
    pc=2113         PUSH
    pc=2114         CLOSURE 0 L155
    pc=2115         PUSH
    pc=2116         CLOSURE 0 L154
    pc=2117         PUSH
    pc=2118         CLOSURE 0 L150
    pc=2119         PUSH
    pc=2120         CLOSURE 0 L149
    pc=2121         PUSH
    pc=2122         ACC 0
    pc=2123         CLOSURE 1 L148
    pc=2124         PUSH
    pc=2125         ACC 1
    pc=2126         CLOSURE 1 L147
    pc=2127         PUSH
    pc=2128         ACC 53
    pc=2129         CLOSURE 1 L144
    pc=2130         PUSH
    pc=2131         ACC 44
    pc=2132         CLOSUREREC 1 [ L75 ]
    pc=2133         ACC 0
    pc=2134         PUSH
    pc=2135         ACC 56
    pc=2136         CLOSURE 2 L141
    pc=2137         PUSH
    pc=2138         ACC 0
    pc=2139         CLOSURE 1 L139
    pc=2140         PUSH
    pc=2141         ACC 47
    pc=2142         CLOSURE 1 L138
    pc=2143         PUSH
    pc=2144         CLOSURE 0 L129
    pc=2145         PUSH
    pc=2146         ACC 21
    pc=2147         CLOSURE 1 L128
    pc=2148         PUSH
    pc=2149         ACC 15
    pc=2150         PUSH
    pc=2151         ACC 23
    pc=2152         CLOSURE 2 L127
    pc=2153         PUSH
    pc=2154         ACC 17
    pc=2155         PUSH
    pc=2156         ACC 24
    pc=2157         CLOSURE 2 L126
    pc=2158         PUSH
    pc=2159         ACC 17
    pc=2160         PUSH
    pc=2161         ACC 25
    pc=2162         PUSH
    pc=2163         ACC 33
    pc=2164         CLOSURE 3 L125
    pc=2165         PUSH
    pc=2166         ACC 18
    pc=2167         PUSH
    pc=2168         ACC 26
    pc=2169         PUSH
    pc=2170         ACC 31
    pc=2171         CLOSURE 3 L124
    pc=2172         PUSH
    pc=2173         ACC 19
    pc=2174         PUSH
    pc=2175         ACC 27
    pc=2176         CLOSURE 2 L123
    pc=2177         PUSH
    pc=2178         ACC 27
    pc=2179         CLOSURE 1 L122
    pc=2180         PUSH
    pc=2181         ACC 27
    pc=2182         CLOSURE 1 L121
    pc=2183         PUSH
    pc=2184         ACC 22
    pc=2185         PUSH
    pc=2186         ACC 29
    pc=2187         CLOSURE 2 L120
    pc=2188         PUSH
    pc=2189         ACC 24
    pc=2190         PUSH
    pc=2191         ACC 30
    pc=2192         CLOSURE 2 L119
    pc=2193         PUSH
    pc=2194         ACC 24
    pc=2195         PUSH
    pc=2196         ACC 31
    pc=2197         PUSH
    pc=2198         ACC 40
    pc=2199         CLOSURE 3 L118
    pc=2200         PUSH
    pc=2201         ACC 25
    pc=2202         PUSH
    pc=2203         ACC 32
    pc=2204         PUSH
    pc=2205         ACC 38
    pc=2206         CLOSURE 3 L117
    pc=2207         PUSH
    pc=2208         ACC 26
    pc=2209         PUSH
    pc=2210         ACC 33
    pc=2211         CLOSURE 2 L116
    pc=2212         PUSH
    pc=2213         ACC 33
    pc=2214         CLOSURE 1 L115
    pc=2215         PUSH
    pc=2216         ACC 15
    pc=2217         PUSH
    pc=2218         ACC 36
    pc=2219         PUSH
    pc=2220         ACC 38
    pc=2221         CLOSURE 3 L114
    pc=2222         PUSH
    pc=2223         ACC 0
    pc=2224         CLOSURE 1 L113
    pc=2225         PUSH
    pc=2226         ACC 1
    pc=2227         PUSH
    pc=2228         ACC 44
    pc=2229         CLOSURE 2 L112
    pc=2230         PUSH
    pc=2231         ACC 2
    pc=2232         CLOSURE 1 L111
    pc=2233         PUSH
    pc=2234         ACC 3
    pc=2235         PUSH
    pc=2236         ACC 43
    pc=2237         CLOSURE 2 L110
    pc=2238         PUSH
    pc=2239         ATOM 0
    pc=2240         PUSH
    pc=2241         CLOSURE 0 L109
    pc=2242         PUSH
    pc=2243         ACC 54
    pc=2244         CLOSURE 1 L108
    pc=2245         PUSH
    pc=2246         ACC 38
    pc=2247         PUSH
    pc=2248         GETGLOBAL {CamlinternalAtomic}
    pc=2249         GETFIELD 0
    pc=2250         APPLY 1
    pc=2251         PUSH
    pc=2252         ACC 0
    pc=2253         CLOSUREREC 1 [ L80 ]
    pc=2254         ACC 1
    pc=2255         CLOSURE 1 L107
    pc=2256         PUSH
    pc=2257         ACC 0
    pc=2258         CLOSURE 1 L106
    pc=2259         PUSH
    pc=2260         ACC 1
    pc=2261         PUSH
    pc=2262         GETGLOBAL "Pervasives.do_at_exit"
    pc=2263         C_CALL 2 "caml_register_named_value"
    pc=2264         CONSTINT 0
    pc=2265         C_CALL 1 "caml_sys_const_naked_pointers_checked"
    pc=2266         BRANCHIFNOT L210
    pc=2267         CLOSURE 0 L105
    pc=2268         PUSH
    pc=2269         ACC 3
    pc=2270         APPLY 1
    pc=2271 L210:   PUSH
    pc=2272         ACC 2
    pc=2273         PUSH
    pc=2274         ACC 32
    pc=2275         PUSH
    pc=2276         ACC 55
    pc=2277         PUSH
    pc=2278         ACC 6
    pc=2279         PUSH
    pc=2280         ACC 5
    pc=2281         PUSH
    pc=2282         ACC 10
    pc=2283         PUSH
    pc=2284         ACC 12
    pc=2285         PUSH
    pc=2286         CLOSURE 0 L104
    pc=2287         PUSH
    pc=2288         CLOSURE 0 L103
    pc=2289         PUSH
    pc=2290         CLOSURE 0 L102
    pc=2291         PUSH
    pc=2292         CLOSURE 0 L101
    pc=2293         PUSH
    pc=2294         CLOSURE 0 L100
    pc=2295         PUSH
    pc=2296         CLOSURE 0 L99
    pc=2297         MAKEBLOCK 0 6
    pc=2298         PUSH
    pc=2299         CLOSURE 0 L98
    pc=2300         PUSH
    pc=2301         ACC 36
    pc=2302         PUSH
    pc=2303         CLOSURE 0 L97
    pc=2304         PUSH
    pc=2305         CLOSURE 0 L96
    pc=2306         PUSH
    pc=2307         CLOSURE 0 L95
    pc=2308         PUSH
    pc=2309         CLOSURE 0 L94
    pc=2310         PUSH
    pc=2311         CLOSURE 0 L93
    pc=2312         PUSH
    pc=2313         CLOSURE 0 L92
    pc=2314         PUSH
    pc=2315         CLOSURE 0 L91
    pc=2316         PUSH
    pc=2317         ACC 46
    pc=2318         PUSH
    pc=2319         ACC 48
    pc=2320         PUSH
    pc=2321         ACC 51
    pc=2322         PUSH
    pc=2323         ACC 48
    pc=2324         PUSH
    pc=2325         CLOSURE 0 L90
    pc=2326         PUSH
    pc=2327         ACC 57
    pc=2328         PUSH
    pc=2329         ACC 56
    pc=2330         PUSH
    pc=2331         ACC 58
    pc=2332         PUSH
    pc=2333         CLOSURE 0 L89
    pc=2334         PUSH
    pc=2335         ACC 62
    pc=2336         PUSH
    pc=2337         ACC 64
    pc=2338         PUSH
    pc=2339         CLOSURE 0 L88
    pc=2340         PUSH
    pc=2341         CLOSURE 0 L87
    pc=2342         PUSH
    pc=2343         CLOSURE 0 L86
    pc=2344         PUSH
    pc=2345         ACC 69
    pc=2346         PUSH
    pc=2347         CLOSURE 0 L85
    pc=2348         PUSH
    pc=2349         CLOSURE 0 L84
    pc=2350         PUSH
    pc=2351         ACC 73
    pc=2352         PUSH
    pc=2353         ACC 75
    pc=2354         PUSH
    pc=2355         ACC 78
    pc=2356         PUSH
    pc=2357         ACC 78
    pc=2358         PUSH
    pc=2359         CLOSURE 0 L83
    pc=2360         PUSH
    pc=2361         ACC 82
    pc=2362         PUSH
    pc=2363         CLOSURE 0 L82
    pc=2364         PUSH
    pc=2365         ACC 87
    pc=2366         PUSH
    pc=2367         ACC 86
    pc=2368         PUSH
    pc=2369         ACC 88
    pc=2370         PUSH
    pc=2371         ACC 53
    pc=2372         PUSH
    pc=2373         ACC 53
    pc=2374         PUSH
    pc=2375         ACC 57
    pc=2376         PUSH
    pc=2377         ACC 57
    pc=2378         PUSH
    pc=2379         ACC 60
    pc=2380         PUSH
    pc=2381         ACC 62
    pc=2382         PUSH
    pc=2383         ACC 64
    pc=2384         PUSH
    pc=2385         ACC 66
    pc=2386         PUSH
    pc=2387         ACC 68
    pc=2388         PUSH
    pc=2389         ACC 70
    pc=2390         PUSH
    pc=2391         ACC 72
    pc=2392         PUSH
    pc=2393         ACC 74
    pc=2394         PUSH
    pc=2395         ACC 76
    pc=2396         PUSH
    pc=2397         ACC 78
    pc=2398         PUSH
    pc=2399         ACC 80
    pc=2400         PUSH
    pc=2401         ACC 82
    pc=2402         PUSH
    pc=2403         ACC 84
    pc=2404         PUSH
    pc=2405         ACC 86
    pc=2406         PUSH
    pc=2407         ACC 88
    pc=2408         PUSH
    pc=2409         ACC 110
    pc=2410         PUSH
    pc=2411         ACC 112
    pc=2412         PUSH
    pc=2413         ACC 114
    pc=2414         PUSH
    pc=2415         ACC 116
    pc=2416         PUSH
    pc=2417         ACC 118
    pc=2418         PUSH
    pc=2419         ACC 120
    pc=2420         PUSH
    pc=2421         ACC 123
    pc=2422         PUSH
    pc=2423         ACC 125
    pc=2424         PUSH
    pc=2425         ACC 128
    pc=2426         PUSH
    pc=2427         ACC 128
    pc=2428         PUSH
    pc=2429         ACC 131
    pc=2430         PUSH
    pc=2431         ACC 133
    pc=2432         PUSH
    pc=2433         ACC 135
    pc=2434         PUSH
    pc=2435         ACC 137
    pc=2436         PUSH
    pc=2437         ACC 139
    pc=2438         PUSH
    pc=2439         ACC 141
    pc=2440         PUSH
    pc=2441         ACC 143
    pc=2442         PUSH
    pc=2443         ACC 145
    pc=2444         PUSH
    pc=2445         ACC 147
    pc=2446         PUSH
    pc=2447         ACC 151
    pc=2448         PUSH
    pc=2449         ACC 150
    pc=2450         PUSH
    pc=2451         ACC 152
    pc=2452         PUSH
    pc=2453         ACC 155
    pc=2454         PUSH
    pc=2455         ACC 157
    pc=2456         PUSH
    pc=2457         ACC 159
    pc=2458         PUSH
    pc=2459         ACC 161
    pc=2460         PUSH
    pc=2461         ACC 163
    pc=2462         PUSH
    pc=2463         ACC 165
    pc=2464         PUSH
    pc=2465         ACC 167
    pc=2466         PUSH
    pc=2467         ACC 169
    pc=2468         PUSH
    pc=2469         ACC 171
    pc=2470         PUSH
    pc=2471         ACC 173
    pc=2472         PUSH
    pc=2473         ACC 175
    pc=2474         PUSH
    pc=2475         ACC 177
    pc=2476         PUSH
    pc=2477         ACC 179
    pc=2478         PUSH
    pc=2479         ACC 181
    pc=2480         PUSH
    pc=2481         ACC 183
    pc=2482         PUSH
    pc=2483         ACC 185
    pc=2484         PUSH
    pc=2485         ACC 188
    pc=2486         PUSH
    pc=2487         ACC 188
    pc=2488         MAKEBLOCK 0 103
    pc=2489         POP 89
    pc=2490         SETGLOBAL {Stdlib}
    pc=2491         BRANCH L212

    pc=2492         RESTART
    pc=2493 L211:   GRAB 1
    pc=2494         ACC 1
    pc=2495         PUSH
    pc=2496         ACC 1
    pc=2497         MAKEBLOCK 0 2
    pc=2498         RETURN 2

    pc=2499 L212:   CLOSURE 0 L211
    pc=2500         PUSH
    pc=2501         GETGLOBAL "hello!"
    pc=2502         PUSH
    pc=2503         GETGLOBAL {Stdlib}
    pc=2504         GETFIELD 45
    pc=2505         APPLY 1
    pc=2506         ACC 0
    pc=2507         MAKEBLOCK 0 1
    pc=2508         POP 1
    pc=2509         SETGLOBAL {Test}
    pc=2510         CONSTINT 0
    pc=2511         PUSH
    pc=2512         GETGLOBAL {Stdlib}
    pc=2513         GETFIELD 102
    pc=2514         APPLY 1
    pc=2515         ATOM 0
    pc=2516         SETGLOBAL {Std_exit}
    pc=2517         STOP
    hello! |}]
;;
