# Projeto
Simulação de uma máquina norma de até 8 registradores em python.

# Operações
As única operações possíveis são:
• ADD: incrementa em uma unidade um determinado registrador

• SUB: decrementa em uma unidade um determinado registrador

• ZER: testa se um determinado registrador contém o valor zero

# Syntaxe para quantidade automática de registradores e inputs
O comentários nas primeiras duas linhas indicam para o script quanto registradores e inputs são necessários. Exemplo:
```
# 3_reg
# 2 inputs
```
Vai usar 3 registradores e pedir dois inputs (A e B).

# Programa inclusos
Os programas são só aquivos de texto a extensão não importa. A extensão .r foi usada para permitir o uso de um syntax highlighting conveniente. Só forneça os valores necessários para a conta (geralmente o valor de `A`, ocasionalmente `B` também).
## soma
Usa  3 registradores.
Pede `A` e `B` como input.

`C := A + B`

## soma2
Usa  3 registradores.
Pede `A` e `B` como input.

`A := A + B`

## mult
Usa  3 registradores.
Pede `A` e `B` como input.

`A := A * B`

## fatorial
Usa  4 registradores.
Pede `A` input.

`B := A!`

## menor
Usa  4 registradores.
Pede `A` e `B` como input.

Testa se o valor do registrador A é menor que do registrador B.
Retorna `C = 1` para `True`, `C = 0` para `false`.

## mod
Usa  8 registradores.
Pede `A` e `B` como input.

Divide `A` por `B`.
Retorna o resultado da divisão em `G`.
Retorna o resto da divisão em `F`

Retorna `H = 1` se o número foi divisível, `H = 0` se não foi divisível.

## primo
Usa  8 registradores.
Pede `A` como input.

Testa se o valor dado em `A` é primo.
Retorna `H = 0` se não for primo,
`H = 1` se for primo.
