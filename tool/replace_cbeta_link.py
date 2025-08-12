import os
import re


def transform_url(text) -> str:
    # Regex pattern for CBETA mobile URLs
    CBETA_PATTERN = re.compile(
        r'https://tripitaka\.cbeta\.org/mobile/index\.php\?index=(N[A-Za-z0-9_]*)'
    )

    replacement = r'https://siongui.github.io/yht-tipitaka/extra/tripitaka.cbeta.org/mobile/\1/'

    return re.sub(CBETA_PATTERN, replacement, text)


def process_file(file_path: str):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = transform_url(content)

    if content != new_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated: {file_path}")
    else:
        print(f"No change: {file_path}")


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

