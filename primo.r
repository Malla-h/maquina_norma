# 8_reg
# 1 input
#
# Calcula se um número é primo
# Retorna H = 1 se for primo, H = 0 se não for.

# P1: Se A == 0, não é primo
1: ZER A 1000 946
946: ADD G 947
947: ADD G 948
948: ADD B 949
949: ADD B 950


# Se A == 1 não é primo
# A == 2 ou A == 3 é primo
950: ZER A 954 951
951: SUB A 952
952: ADD C 953
953: ADD D 950

954: SUB C 955
955: ZER C 1000 956
956: SUB C 957
957: ZER C 998 958
958: SUB C 959
959: ZER C 998 960


# Primo
998: ADD H 1000

# Não primo
999: ZER A 1000 1000

# Deletar C
960: ZER C 962 961
961: SUB C 960

# Restaurar A
962: ZER D 3 963
963: SUB D 964
964: ADD A 962


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
    19: ZER A 171 20
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

#fix: quando a divisão é perfeita, H acaba com valor 1 menor que o esperado
171: ZER B 172 29
172: ADD H 29

# D (divisor) para A
29: ZER D 32 30
30: ADD A 31
31: SUB D 29

# Delete B
32: ZER B 35 33
33: SUB B 32

# H (resultado) para B
35: ZER H 38 36
36: ADD B 37
37: SUB H 35

# C (dividendo) para F
38: ZER C 50 39
39: ADD F 40
40: SUB C 38


# a % b = a - ( b * (a//b) )
# F - (A*B)
#
# L9: A * B
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
59: ZER A 64 60
60: SUB A 59

# M3: Transferir o resultado de C para A
# 61: ZER C 64 62
# 62: ADD A 63
# 63: SUB C 61
##################################################

# Copiar F para A e B
64: ZER F 68 65
65: ADD A 66
66: ADD B 67
67: SUB F 64

# A - C
68: ZER C 71 69
69: SUB A 70
70: SUB C 68

# Resto = A. Resto == 0 nao é primo
71: ZER A 999 72

# Preparar para loop
72: ZER A 74 73
73: SUB A 72

# Add G (proximo divisor). Se G >= B (dividendo). É primo.
74: ADD G 75

# G para E F (proximo divisor)
75: ZER G 79 76
76: ADD E 77
77: ADD F 78
78: SUB G 75

# B para C D (dividendo)
79: ZER B 830 80
80: ADD C 81
81: ADD D 82
82: SUB B 79

830: ADD E 83
# E < D ?
83: ZER E 87 84
84: ZER D 860 85
85: SUB E 86
86: SUB D 83


# FALSO. É PRIMO.
860: ZER A 998 998

# TRUE. Continuar.
87: ZER A 88 88

# Concentar formato
# C para A
88: ZER C 91 89
89: ADD A 90
90: SUB C 88

# F pra B G
91: ZER F 95 92
92: ADD B 93
93: ADD G 94
94: SUB F 91

# Delete D
95: ZER D 97 96
96: SUB D 95

# LOOP
97: ZER A 3 3
