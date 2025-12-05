# NOTE: You must run this script from the base folder of the project
# TODO: Make this more efficient by only removing/adding the files that did change

ROKU_DEST = "10.195.1.246"
ROKU_PASS = "stardev"
ZIP_FILENAME = "code.zip"

import os
import zipfile
import requests
from requests.auth import HTTPDigestAuth
import argparse


def log_path(action: str, path: str, args):
    if not args.quiet:
        print(f"[Build] {action:<24} '{path}'")


def append_folder(folder, zip_file: zipfile.ZipFile, args):
    for file in os.listdir(folder):
        abs_file = os.path.join(folder, file)

        if args.exclude.__contains__(file):
            if not os.path.isdir(abs_file):
                log_path("Skipping file", file, args)
            else:
                log_path("Skipping folder", file, args)

            continue # skip the rest

        if file.endswith(".zip"):
            log_path("Skipping zip", file, args)
            
            continue

        if os.path.isdir(file):
            log_path("Adding folder", file, args)
            append_folder(abs_file, zip_file, args)
        else:
            log_path("Adding file", file, args)
            zip_file.write(abs_file, os.path.relpath(abs_file))


def main(args: argparse.Namespace):
    for file in os.listdir():
        if file.endswith(".zip"):
            log_path("Deleted zip file", file, args)
            os.remove(file)

    file = zipfile.ZipFile("code.zip", "w")
    append_folder(os.path.dirname(os.path.abspath(__file__)), file, args)
    file.close()

    if not args.no_send:
        response = None
        with open(ZIP_FILENAME, "rb") as zip_archive:
            try:
                response = requests.post(
                    "http://" + ROKU_DEST + "/plugin_install",
                    auth=HTTPDigestAuth("rokudev", ROKU_PASS),
                    files={"archive": ("code.zip", zip_archive, "application/zip")},
                    data={"mysubmit": "Install", "passwd": ROKU_PASS},
                )
            except requests.exceptions.RequestException as e:
                print(
                    "[Request] There was an error with sending the package to your Roku device."
                )

        if response != None:
            print("[Response] " + str(response.status_code))
            if response.status_code != 200:
                filename = "error_response.html"
                print(
                    "[Response] Something is wrong with your code. Saving to "
                    + filename
                )

                with open(filename, "w") as file:
                    file.write(response.text)

            response.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="build.py", description="A build script for Roku application development."
    )

    parser.add_argument(
        "-n",
        "--no-send",
        help="Send the code over to the Roku device.",
        action="store_true",
    )
    parser.add_argument(
        "-q",
        "--quiet",
        help="Print only errors.",
        action="store_true",
    )
    parser.add_argument(
        "-e",
        "--exclude",
        help="Exclude certain files/dirs from saving to the Zip files. Specify dirs with '/' at the end of the name ie: 'myfolder/'.",
        nargs="+",
        type=str,
    )

    args = parser.parse_args()

    main(args)

    # main(send)
