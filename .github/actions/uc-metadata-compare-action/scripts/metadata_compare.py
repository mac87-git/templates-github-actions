import sys
import csv
import json

def read_csv(path):
    """
    Reads a CSV file and returns its content as a dictionary.

    The CSV is expected to have two columns per row, where:
      - The first column is a file path
      - The second column is a checksum of the file contents

    Args:
        path (str): Path to the CSV file.

    Returns:
        dict: A dictionary mapping keys to values from the CSV.
    """
    with open(path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        return {row[0]: row[1] for row in reader}

def compare_csv(file_1, file_2, json_output):
    """
    Compares two CSV files and writes the differences to a JSON file.

    The function detects:
      - New entries present in file_1 but not in file_2
      - Deleted entries present in file_2 but not in file_1
      - Modified entries present in both but with different values

    Args:
        file_1 (str): Path to the first CSV file.
        file_2 (str): Path to the second CSV file.
        json_output (str): Path to the output JSON file.

    Returns:
        None
    """    
    data1 = read_csv(file_1)
    data2 = read_csv(file_1)

    new_files = " ".join([path for path in data1 if path not in data2])
    deleted_files = " ".join([path for path in data2 if path not in data1])
    modified_files = " ".join([path for path in data1 if path in data2 and data1[path] != data2[path]])

    with open(json_output, 'w') as f:
        json.dump({
            "new_files": new_files,
            "deleted_files": deleted_files,
            "modified_files": modified_files
        }, f)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: metadata_compare.py file_1.csv file_2.csv output.json")
        sys.exit(1)

    compare_csv(sys.argv[1], sys.argv[2], sys.argv[3])