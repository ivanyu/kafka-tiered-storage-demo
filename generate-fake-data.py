import json
import random
import string
import sys


def random_string(length: int) -> string:
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))


count = int(sys.argv[1])

for i in range(count):
    datum = {
        "id": i,
        "name": random_string(10),
        "address": random_string(20),
        "items": [random_string(5) for _ in range(random.randint(5, 10))]
    }
    print(json.dumps(datum))
