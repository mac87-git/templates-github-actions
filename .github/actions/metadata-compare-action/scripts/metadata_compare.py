import sys
import csv
import json

def leer_csv(path):
    with open(path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        return {row[0]: row[1] for row in reader}

def comparar(archivo1, archivo2, salida_json):
    data1 = leer_csv(archivo1)
    data2 = leer_csv(archivo2)

    nuevos = [path for path in data1 if path not in data2]
    borrados = [path for path in data2 if path not in data1]
    cambiados = [path for path in data1 if path in data2 and data1[path] != data2[path]]

    with open(salida_json, 'w') as f:
        json.dump({
            "nuevos": nuevos,
            "borrados": borrados,
            "cambiados": cambiados
        }, f)

if _name_ == "_main_":
    if len(sys.argv) != 4:
        print("Uso: compare_csv.py archivo1.csv archivo2.csv salida.json")
        sys.exit(1)

    comparar(sys.argv[1], sys.argv[2], sys.argv[3])