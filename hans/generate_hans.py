import os
import sys
import opencc

converter = opencc.OpenCC('t2s.json')

contentdir = sys.argv[1]

for subdir, dirs, files in os.walk(contentdir):
    for file in files:
        if file.endswith("%zh-hant.rst"):
            hant_file = os.path.join(subdir, file)
            #print(hant_file)

            with open(hant_file, 'r') as f_hant:
                hans_file = hant_file.replace("%zh-hant.rst", "%zh-hans.rst")
                #print(hans_file)

                with open(hans_file, 'w') as f_hans:
                    hans_content = converter.convert(f_hant.read())
                    hans_content = hans_content.replace("%zh-hant.rst", "%zh-hans.rst")
                    f_hans.write(hans_content)

                print(hans_file + " created!")
