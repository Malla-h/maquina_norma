# Queremos o fatorial do valor inicializado em A
# L0: Se A for inicializado com 0, resultado é 1
ZER A L99

# L1: B := A - 1. Mas mantém o valor original de A em A,
# usando C como buffer.
ZER A L1.1
ADD B
ADD C
SUB A L1

#   L1.1: Restaurar A.
ZER C L1.2
ADD A
SUB C L1.1

#   L1.2: A e B estão iguais. Então B := B - 1 para termos B == A - 1.
#   Se B ficar igual a 0, ir pro final?.
SUB B 9
ZER B L99 L2


############### MULTIPLICAÇÃO #################
# M1: Quando B = 0, vamos para finalização
ZER B M2 M1.1

#   M1.1: Adicionar A em C e D
ZER A M1.2
SUB A
ADD C
ADD D M1.1

#   M1.2: Restaurar A. Agora A e C tem o mesmo valor.
ZER D M1.4
ADD A
SUB D M1.2

#   M1.4: Vamos repetir o loop pai B vezes
SUB B M1

# Finalização
# M2: O resultado está em C. Liberemos A para transferir.
ZER A M3
SUB A M2

# M3: Transferir o resultado de C para A
ZER C 100
ADD A
SUB C M3
###############################################
