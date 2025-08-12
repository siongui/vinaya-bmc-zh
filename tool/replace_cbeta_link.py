import os
import re

# Regex pattern for CBETA mobile URLs
CBETA_PATTERN = re.compile(
    r'https://tripitaka\.cbeta\.org/mobile/index\.php\?index=(N.*[A-Za-z0-9])'
)


def process_file(file_path: str):
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for i, line in enumerate(f, 1):
                matches = CBETA_PATTERN.findall(line)
                if matches:
                    full_matches = CBETA_PATTERN.finditer(line)
                    for match in full_matches:
                        print(f"{file_path} (line {i}): {match.group()}")
    except Exception as e:
        print(f"Error reading {file_path}: {e}")


def find_cbeta_links(directory, file_extension=None):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file_extension and not file.endswith(file_extension):
                continue

            file_path = os.path.join(root, file)
            process_file(file_path)


if __name__ == "__main__":
    # 🔍 Set your search directory and (optional) file extension
    search_dir = '../content/pages/'
    find_cbeta_links(search_dir, file_extension='hant.rst')  # Use None to check all file types

