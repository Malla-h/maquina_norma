# 3_reg
# 2 inputs
#
# L1: Quando B = 0, vamos para finalização
1: ZER B 10 2

#   L1.1: Adicionar A em C e D
2: ZER A 6 3
3: SUB A 4
4: ADD C 5
5: ADD D 2

#   L1.2: Restaurar A usando D.
6: ZER D 9 7
7: ADD A 8
8: SUB D 6

#   L1.4: Vamos repetir o loop pai B vezes
9: SUB B 1

# Finalização
# L2: O resultado está em C. Liberemos A para transferir.
10: ZER A 12 11
11: SUB A 10

# L3: Transferir o resultado de C para A
12: ZER C 100 13
13: ADD A 14
14: SUB C 12