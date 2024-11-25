# 8_reg
# input(A)
#

# P1: Se A == 0, não é primo
1: ZER A 1000 80

# B tem que começar em 2
80: ADD B 81
81: ADD B 82

# Passar A pro C e D e F
82: ZER A 86 83
83: ADD C 84
84: ADD D 85
85: SUB A 500
500: ADD F 82

# Restaurar A
86: ZER D 89 87
87: ADD A 88
88: SUB D 86

# Passar B para D e E
89: ZER B 93 90
90: ADD D 91
91: ADD E 92
92: SUB B 89

# Restaurar B
93: ZER E 96 94
94: ADD B 95
95: SUB E 93

# D < C ? (b < a?) Se for continua o loop, se não, é primo
96: SUB D 97
97: SUB C 98
98: ZER C 100 99
99: ZER D 2 96

# É primo
100: ADD H 1000


#### A % B
# P2: Se B == 0 raios cósmicos causaram um bit flip na sua memória.
2: ZER B 1000 3

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
    19: ZER A 75 20
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
75: ZER B 76 29
76: ADD H 29

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

# LBonus: Salvar o resultado de F em B e D para usar em outro programa
64: ZER F 68 65
65: ADD B 66
66: ADD D 67
67: SUB F 64

# (a) está em B ou D.
# Calcular a - ( b * (a//b) ) ou seja
# L10: Calcular B - A
68: ZER A 71 69
69: SUB B 70
70: SUB A 68

# L11: Remover E que não tem nada de importancia
71: ZER E 77 72
72: SUB E 71

# Vamos fazer H = 0 se o número foi divisível e H = 1 se não foi divisível
# Loop tudo enquanto nao tiver uma divisao perfeita
73: ZER B 1000 74
74: ADD H 101

# Botar o resto da divisao em F
77: ZER B 73 78
78: SUB B 79
79: ADD F 77


# Zerar tudo antes de dar o loop (D, F, G, H)
101: ZER D 103 102
102: SUB D 101
103: ZER F 105 104
104: SUB F 105
105: ZER G 107 106
106: SUB G 107
107: ZER H 81 118
118: SUB H 107