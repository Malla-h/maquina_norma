import os
import pprint

slow_mode = False

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

        # Modo lento
        if file_name.lower() == "slow":
            global slow_mode
            slow_mode = not slow_mode
            print(f"Modo lento: {slow_mode}")

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
        "[slow] para ativar o modo lento.\n"
    )


def print_output(instr):

    if slow_mode:
        input();print("\033[{}C\033[1A".format(1 + 1), end="")

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

    try:
        with open(file_name, "r") as file:
            # Ler primeira linha e pegar terceiro caractere, que contém a quantidade mínima de registradores necessários
            first_line = file.readline()
            num_registers = int(first_line[2]) if len(first_line) >= 3 else 8

            # Ler a segunda linha e pegar terceiro caractere, que contém a quantidade de inputs necessários
            second_line = file.readline()
            num_inputs = int(second_line[2]) if len(second_line) >= 3 else 8
    except (FileNotFoundError, ValueError, IndexError):
        num_registers = 8
        num_inputs = 8

    print(f"Quantidade de registradores: {num_registers}")

    registers = [0] * num_registers
    for i in range(num_inputs):
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

# Imprimir a descrição do programa na quarta linha
try:
    with open(file_name, "r", encoding="utf-8") as file:
        for i in range(3):
            file.readline()
        print(file.readline().strip())
except FileNotFoundError:
    print("Descrição do programa: Arquivo nao encontrado")
except IndexError:
    print("A descrição não está disponível.")
print()

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
# pprint.pprint(instructions)


# Instrução atual. Começa com a primeira instrução.
current_instr: int = 1
print_output(0)
# Executar as instruções. Se o numero da instrução for maior do que o tamanho do dicionário, parar.
while current_instr <= max(instructions):
    previous_instr = current_instr
    function = KEYWORDS.get(instructions[current_instr][0])
    if function:
        if function(instructions[current_instr][1]):
            current_instr = int(instructions[current_instr][2])
        else:
            current_instr = int(instructions[current_instr][3])

    print_output(previous_instr)
