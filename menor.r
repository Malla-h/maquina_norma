# 4_reg
# 2 inputs
#
# Teste se o valor de um registrador A é menor que um registrador B. Resultado em C = 1 True, C = 0 False.
# A < B usando C, D, E
# O resultado final está em C: 0 ou 1.

# P1: Testar se A == 0
1: ZER A 2 3

# P2: Caso A == 0, testar se B == 0
2: ZER B 9 8

# P3: Caso A != 0, testar se B == 0
3: ZER B 9 4

# P4: Nem A nem B são 0
# Loop que subratai A e B para ver quem chega em 0 primeiro
4: SUB A 5
5: SUB B 6
6: ZER B 9 7
7: ZER A 8 4



################
# True
8: ADD C 100

# False
9: ZER C 100 100