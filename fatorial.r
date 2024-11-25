# 4_reg
# 1 input
#
# Fatorial do valor dado A. O resultado final é em B.
# L0: Se A for inicializado com 0, resultado é 1
1: ZER A 99 2

# L1: B := A - 1. Mas mantém o valor original de A em A,
# usando C como buffer.
2: ZER A 6 3
3: ADD B 4
4: ADD C 5
5: SUB A 2

    #   L1.1: Restaurar A usando C.
    6: ZER C 9 7
    7: ADD A 8
    8: SUB C 6

    #   L1.2: A e B estão iguais. Então B := B - 1 para termos B == A - 1.
    #   Se B ficar igual a 0, ir pro final?.
    9: SUB B 10
    10: ZER B 99 25


############### MULTIPLICAÇÃO #################
# M1: Quando B = 0, vamos para finalização
11: ZER B 20 12

    #   M1.1: Adicionar A em C e D
    12: ZER A 16 13
    13: SUB A 14
    14: ADD C 15
    15: ADD D 12

    #   M1.2: Restaurar A usando D.
    16: ZER D 19 17
    17: ADD A 18
    18: SUB D 16

    #   M1.4: Vamos repetir o loop pai B vezes
    19: SUB B 11

# Finalização
# M2: O resultado está em C. Passar para B.
20: ZER C 23 21
21: ADD B 22
22: SUB C 20

# M3: Decrementar A para a proxima multiplicação
23: SUB A 24
24: ZER A 99 11
###############################################

########## PRIMEIRA MULTIPLICAÇÃO #############
# M1: Quando B = 0, vamos para finalização
25: ZER B 34 26

    #   M1.1: Adicionar A em C e D
    26: ZER A 30 27
    27: SUB A 28
    28: ADD C 29
    29: ADD D 26

    #   M1.2: Restaurar A usando D.
    30: ZER D 33 31
    31: ADD A 32
    32: SUB D 30

    #   M1.4: Vamos repetir o loop pai B vezes
    33: SUB B 25

# Finalização
# M2: O resultado está em C. Passar para B.
34: ZER C 37 35
35: ADD B 36
36: SUB C 34

# M3: Decrementar A para a próxima multiplicação
37: ZER A 99 38
38: SUB A 39
39: ZER A 99 40
40: SUB A 11
###############################################
