# 8_reg
# input(A,B)
#

# Primeiro calcular A // B

# P1: Se A == 0, para qualquer B, A / B = 0
1: ZER A 100 2

# P2: Se B == 0 e A != 0, A / B = indefinido. Retorar 0 mesmo assim.
2: ZER B 100 3

# P3: Calcular A / B
    # L1: Copiar A para C e B para D

        # L1.1: Copiar A para C e D.
        3: ADD C 4
        4: ADD D 5
        5: SUB A 6
        6: ZER A 7 3

        # L1.2: Restaurar A usando D.
        7: ADD A 8
        8: SUB D 9
        9: ZER D 10 7

        # L1.3: Copiar B para D e E
        10: ADD D 11
        11: ADD E 12
        12: SUB B 13
        13: ZER B 14 10

        # L1.4: Restaurar B usando E
        14: ADD B 15
        15: SUB E 16
        16: ZER E 17 14

    # L2: Subtrair B de A. Quando B chegar a 0, adicionar 1 ao contador H.
    # Se A chegar a 0, chegamos ao fim da divisão.
    17: SUB A 18
    18: SUB B 19
    19: ZER A 29 20
    20: ZER B 21 17

    # Adicionar ao contador H (resto da divisão)
    21: ADD H 22

    # L3: Restaurar B usando D. Colocar o valor em E para restaurar D depois.
    22: ADD B 23
    23: ADD E 24
    24: SUB D 25
    25: ZER D 26 22

    # L4: Restaurar D usando E.
    26: ADD D 27
    27: SUB E 28
    28: ZER E 17 26


# A % B = A - ( B * (A//B) ) originalmente, mas
# o valor de B está agora em D
# e o valor de A está em C.
#
# Colocar os A no lugar original. Copiar o resuntado da divisão (H) para B, para usar no calculo do resto da divisão
#
# L5: zerar todos os registradores que não estamos usando (A, B, D, E, F, G)
29: ZER A 31 30
30: SUB A 29
31: ZER B 33 32
32: SUB B 31
33: ZER E 35 34
34: SUB E 33
35: ZER F 37 36
36: SUB F 35
37: ZER G 39 38
38: SUB G 37

# L6: Transferir valor de D para A e E.
39: ZER D 43 40
40: ADD A 41
41: ADD E 42
42: SUB D 39

# L7: Transferir o valor de H para B e G
43: ZER H 47 44
44: ADD B 45
45: ADD G 46
46: SUB H 43

# L8: C precisa estar em outro lugar para não atrapalhar na multiplicação
47: ZER C 50 48
48: ADD F 49
49: SUB C 47


# a % b = a - ( b * (a//b) )
# Nesse ponto, o resultado de (a//b) está em B e (a) está em A
# L9: Calcular b * (a//b) que é igual a A * B
#
############## Multiplicação #####################
# M1: Quando B = 0, vamos para finalização
50: ZER B 59 51

#   M1.1: Adicionar A em C e D
51: ZER A 55 52
52: SUB A 53
53: ADD C 54
54: ADD D 51

#   M1.2: Restaurar A usando D.
55: ZER D 58 56
56: ADD A 57
57: SUB D 55

#   M1.4: Vamos repetir o loop pai B vezes
58: SUB B 50

# Finalização
# M2: O resultado está em C. Liberemos A para transferir.
59: ZER A 61 60
60: SUB A 59

# M3: Transferir o resultado de C para A
61: ZER C 64 62
62: ADD A 63
63: SUB C 61
##################################################

# (a) está em F.
# Calcular a - ( b * (a//b) ) ou seja
# L10: Calcular F - A
64: ZER A 67 65
65: SUB F 66
66: SUB A 64

# O resultado da divisão está em G.
# O resto da divisão está em F.

# Vamos fazer H = 0 se o número foi divisível e H = 1 se não foi divisível
67: ZER F 100 68
68: ADD H 100