def count_up_to(maximum: int):
    count = 1
    while count <= maximum:
        yield count
        count += 1


# Using the generator
number = count_up_to(5)
print(list(number))


def add_numbers(a: int, b: int):
    return a + b


result = add_numbers(5, 6)
print(result)
