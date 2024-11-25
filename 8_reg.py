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
    # Pegar o diretorio em que o script se encontra
    script_dir = os.path.dirname(os.path.realpath(__file__))

    while True:
        print("Digite o nome do arquivo ou um comando:")
        file_name = input().strip()

        if not file_name:
            print("Entrada vazia. Tente novamente.")
            continue

        if file_name.lower() == "sair" or file_name.lower() == "exit":
            print("Saindo...")
            exit(0)

        # Listagem de arquivos
        if file_name.lower() == "ls":
            files = os.listdir(script_dir)
            for file in files:
                print(f" {file}")
            print()
            continue

        # Checar se tem um arquivo com o nome que foi digitado
        if not os.path.splitext(file_name)[1]:  # Se não tiver extensão
            matching_files = [
                f for f in os.listdir(script_dir) if os.path.splitext(f)[0] == file_name
            ]
            if matching_files:
                file_name = matching_files[0]  # Pegar a primeira match
            else:
                print("Arquivo não encontrado. Tente novamente.\n")
                continue

        # Checar se o arquivo existe no diretório do script
        full_path = os.path.join(script_dir, file_name)
        if os.path.exists(full_path):
            print()
            return full_path

        print("Arquivo não encontrado. Tente novamente.\n")


def print_comandos():
    print(
        "\nComandos disponiveis:\n\n"
        "[sair] ou [exit] para sair.\n"
        "[ls] para listar os arquivos disponiveis.\n"
    )


def print_output(instr):

    # input();print("\033[{}C\033[1A".format(1 + 1), end="")

    list_as_str = ",".join(map(str, registers))
    if instr == 0:
        print(f"(({list_as_str}), M) Entrada de Dados")
        return
    else:
        print(f"(({list_as_str}), {instr}) ", end="")

    # Pegar o operador da instrução
    operator = instructions[instr][0]
    operand1 = instructions[instr][1]
    operand2 = instructions[instr][2]

    if operator == "ADD":
        print(f"FACA ADD ({operand1}) VA_PARA {operand2}")
    elif operator == "SUB":
        print(f"FACA SUB ({operand1}) VA_PARA {operand2}")
    elif operator == "ZER":
        operand3 = instructions[instr][3]
        print(f"SE ZER ({operand1}) VA_PARA {operand2} SENAO VA_PARA {operand3}")


def initialize_registers():
    print("Escolha a quantidade de registradores\n(1 a 8, default 8):")
    while True:
        try:
            user_input = input().strip()
            if not user_input:
                num_registers = 8
            else:
                num_registers = int(user_input)

            if 1 <= num_registers <= 8:
                break
            else:
                print("Quantidade de registradores inválida. Tente novamente.")

        except ValueError:
            print("Entrada inválida. Tente novamente.")

    print(
        "\nDigite o valor para inicializar os registradores (ENTER para inicializar com 0):"
    )
    registers = [0] * num_registers
    for i in range(num_registers):
        while True:
            try:
                user_input = input(f"{chr(ord('A') + i)}: ").strip()
                registers[i] = int(user_input) if user_input else 0
                break
            except ValueError:
                print("Entrada inválida. Tente novamente.")

    return registers


KEYWORDS = {
    "ADD": add,
    "SUB": sub,
    "ZER": zer,
}

print_comandos()
file_name = get_file_name_from_user()

# registers: A  B  C  D  E  F  G  H
# registers = [0, 0, 0, 0, 0, 0, 0, 0]

# Pegar o valor dos registradores com o usuario
registers = initialize_registers()


# Salvar as instruções em um dicionário. Cada linha do arquivo será uma chave do dicionário.
# Cada chave será uma lista de palavras.
with open(file_name) as file:
    instructions = {}
    for line in file:

        if not line or line.strip().startswith("#") or line.isspace():
            continue

        tokens = line.strip().split()
        line_number = tokens[0][:-1]
        if not line_number.isdigit():
            print("Invalid line number:", line)
            break

        instructions[int(line_number)] = tokens[1:]

# Descomentar para imprimir o dicionário de instruções para depuração
pprint.pprint(instructions)


# Instrução atual. Começa com a primeira instrução.
current_instr: int = 1
print_output(0)
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
