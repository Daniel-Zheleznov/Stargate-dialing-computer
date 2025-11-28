# NOTE: You must run this script from the base folder of the project
# TODO: Make this more efficient by only removing/adding the files that did change

ROKU_DEST = "10.195.1.246"
ROKU_PASS = "stardev"
ZIP_FILENAME = "code.zip"

import os
import zipfile
import requests
from requests.auth import HTTPDigestAuth

def append_folder(folder, zip_file: zipfile.ZipFile):
    for file in os.listdir(folder):
        file = os.path.join(folder, file)

        if os.path.isdir(file):
            print("[Build] Adding folder '" + file + "'")
            append_folder(file, zip_file)

        elif file.endswith(".zip") == True:
            print("[Build] Skipping zip  '" + file + "'")
        
        else:
            print("[Build] Adding file   '" + file + "'")
            zip_file.write(file)

def package_project():
    zip_file = zipfile.ZipFile(ZIP_FILENAME, "a", zipfile.ZIP_DEFLATED)
    for file in os.listdir():
        file = os.path.relpath(file)

        if os.path.isdir(file):
            print("[Build] Adding folder '" + file + "'")
            append_folder(file, zip_file)

        elif file.endswith(".zip") == True:
            print("[Build] Skipping zip  '" + file + "'")
        
        else:
            print("[Build] Adding file   '" + file + "'")
            zip_file.write(file)

    zip_file.close()

def main():
    for file in os.listdir():
        if file.endswith(".zip"):
            print("[Build] Deleted '" + file + "'")
            os.remove(file)

    package_project()

    response = None
    with open(ZIP_FILENAME, "rb") as zip_archive:
        try:
            response = requests.post(
                "http://" + ROKU_DEST + "/plugin_install",
                auth = HTTPDigestAuth("rokudev", ROKU_PASS),
                files = {"archive": ("code.zip", zip_archive, "application/zip")},
                data = {
                    "mysubmit": "Install",
                    "passwd": ROKU_PASS
                }
            )
        except requests.exceptions.RequestException as e:
            print("[Request] There was an error with sending the package to your Roku device.")

    if response != None:
        print("[Response] " + str(response.status_code))
        if response.status_code != 200:
            filename = "error_response.html"
            print("[Response] Something is wrong with your code. Saving to " + filename)
        
            with open(filename, "w") as file:
                file.write(response.text)

        response.close()

if __name__ == "__main__":
    main()