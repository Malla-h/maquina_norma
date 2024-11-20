import os
import pprint


def add(operand: str):
    # Usar a tabela ASCII para pegar o valor do registrador correspondente
    register = ord(operand) - ord("A")

    # Incrementar o valor do registrador
    registers[register] += 1
    return True


def sub(operand: str):
    # Usar a tabela ASCII para pegar o valor do registrador correspondente
    register = ord(operand) - ord("A")

    # Decrementar o valor do registrador. Não pode ser negativo
    registers[register] = max(0, registers[register] - 1)
    return True


def zer(operand: str) -> bool:
    # Usar a tabela ASCII para pegar o valor do registrador correspondente
    register = ord(operand) - ord("A")

    # retornar true se o valor do registrador for zero
    return registers[register] == 0


def get_file_name_from_user():
    while True:
        print("Digite o nome do arquivo com as instruções:")
        file_name = input().strip()

        if not file_name:
            print("Entrada vazia. Tente novamente.")
            continue

        if file_name.lower() == "sair" or file_name.lower() == "exit":
            print("Saindo...")
            exit(0)

        # Listagem de arquivos
        if file_name.lower() == "ls":
            files = os.listdir(".")
            for file in files:
                print(f" {file}")
            print()
            continue

        # Se o arquivo não tiver extensão, assumir que é .txt
        if not os.path.splitext(file_name)[1]:
            file_name += ".txt"
            continue

        if os.path.exists(file_name):
            return file_name

        print("Arquivo não encontrado. Tente novamente.")

def print_comandos():
    print(
        "comandos disponiveis:\n"
        "sair ou exit para sair.\n"
        "ls para listagem de arquivos.\n"
        "comandos para ver a lista comandos\n"
    )


def print_output(previous_instr):
    list_as_str = ",".join(map(str, registers))
    print(f"(({list_as_str}), {previous_instr}) ", end="")

    # Pegar o operador da instrução
    operator = instructions[previous_instr][0]
    operand1 = instructions[previous_instr][1]
    operand2 = instructions[previous_instr][2]

    if operator == "ADD":
        print(f"FACA ADD ({operand1}) VA_PARA {operand2}")
    elif operator == "SUB":
        print(f"FACA SUB ({operand1}) VA_PARA {operand2}")
    elif operator == "ZER":
        operand3 = instructions[previous_instr][3]
        print(f"SE ZER ({operand1}) VA_PARA {operand2} SENAO VA_PARA {operand3}")


# registers  A  B  C  D  E  F  G  H
registers = [0, 0, 0, 0, 0, 0, 0, 0]

KEYWORDS = {
    "ADD": add,
    "SUB": sub,
    "ZER": zer,
}

print_comandos()
file_name = get_file_name_from_user()

# Pegar o valor dos registradores com o usuario
print(
    "Digite o valor para inicializar os registradores (ENTER para inicializar com 0):"
)
for i in range(len(registers)):
    while True:
        try:
            user_input = input(f"{chr(ord('A') + i)}: ").strip()
            registers[i] = int(user_input) if user_input else 0
            break
        except ValueError:
            print("Entrada inválida. Tente novamente.")


# Salvar as instruções em um dicionário. Cada linha do arquivo será uma chave do dicionário.
# Cada chave será uma lista de palavras.
with open(file_name) as file:
    instructions = {}
    for line in file:

        if not line:
            continue

        tokens = line.strip().split()
        line_number = tokens[0][:-1]
        if not line_number.isdigit():
            print("Invalid line number:", line)
            break

        instructions[int(line_number)] = tokens[1:]

# pprint.pprint(instructions)


# Instrução atual. Começa com a primeira instrução.
current_instr: int = 1
# Executar as instruções. Se o numero da instrução for maior do que o tamanho do dicionário, parar.
while current_instr <= len(instructions):
    previous_instr = current_instr
    function = KEYWORDS.get(instructions[current_instr][0])
    if function:
        if function(instructions[current_instr][1]):
            current_instr = int(instructions[current_instr][2])
        else:
            current_instr = int(instructions[current_instr][3])

    print_output(previous_instr)
