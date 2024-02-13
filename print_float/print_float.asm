format ELF64 executable 3

include 'library.asm'

; IEEE 754 floating point format for double is:
; sign (1 bit) exponent (11 bits) mantissa (52 bits)
; the exact number is (-1)^sign * (1.mantissa) * 2^(exponent - 1023)
; or (-1)^sign * (1{mantissa}) * 2^(exponent - 1023 - 52)
; s = (-1)^sign, m = (1{mantissa}) = (1 << 52) + mantissa, exp = exponent - 1023 - 52
; so the number is s * m * 2^exp
; now we want to be able to print it with any precision (p digits)
; if exp < 0:
;   result = s * m * 10*p / 2^|exp|
;   now to use only inteegeer operations it would be nice to get rid of the division by 2^|exp|
;   result = s * m * 5^|exp| * 10*p / 2^|exp| * 5^|exp| = s * m * 5^|exp| * 10^(p-|exp|)
;   now it's nice and easy, powers of 10 just move the decimal point
;   so we only need to learn how to put the m * 5^|exp| into string,
;   m is in the range [0, 2**53], 5^|exp| is in the range [0, 5**1075]
;   m * 5^|exp| can easily be excede the 64 bit dword, it would go up to 2550 bit number
;   so it's not possible to just multiply those numbers, we have do to some kind of long multiplication
; else:
;   result = s * m * 10*p * 2^|exp|
;   here we already have only integer multiplication and nice powers of 10
;   unfortunately m * 2^|exp| still can be too big to fit into 64 bit dword
;   the same problem as before, we have to do some kind of long multiplication
; to get the float 


segment readable executable

entry main
main:
    print_str enter_a_number, enter_a_number_length

    call read_int

    print_str got_number_from_string, got_number_from_string_length

    call print_int

    call factorial

    print_str calculation_result, calculation_result_length

    call print_int

    exit 0


segment readable writable
    enter_a_number db 'Enter a number: '
    enter_a_number_length = $-enter_a_number

    got_number_from_string db 'Got number from a string: '
    got_number_from_string_length = $-got_number_from_string

    calculation_result db 'Calculation result: '
    calculation_result_length = $-calculation_result

    flt dq 3.14

; display/i $pc
