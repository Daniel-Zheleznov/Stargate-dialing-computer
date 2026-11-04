# NOTE: You must run this script from the base folder of the project

ROKU_DEST = "10.195.1.248"
ROKU_PASS = "stardev"
ZIP_FILENAME = "code.zip"

import os
import zipfile
import requests
from requests.auth import HTTPDigestAuth
import argparse
import fnmatch
import re

def is_excluded(rel_file, excludes):
    name = os.path.basename(rel_file)
    for pattern in excludes:
        if any(ch in pattern for ch in "*?["):
            # Glob pattern: match against full relative path or just the filename
            if fnmatch.fnmatch(rel_file, pattern) or fnmatch.fnmatch(name, pattern):
                return True
        elif pattern in rel_file:
            # Plain string: old substring behavior
            return True
    return False


def log(action: str, path: str, args: argparse.Namespace, process: str = "Build"):
    if not args.quiet:
        print(f"[{process.capitalize():^10}] {action:<24} '{path}'")


def add_files_to_zip(zipfolder: zipfile.ZipFile, args: argparse.Namespace, base: str = None):
    if base is None:
        base = os.getcwd()

    excludes = set(args.exclude) if args.exclude else set()

    for root, dirs, files in os.walk(base):
        for file in files:
            rel_dir = os.path.relpath(root, base)
            rel_file = os.path.join(rel_dir, file) if rel_dir != '.' else file

            if is_excluded(rel_file, excludes):
                log("Skipping", rel_file, args)
                continue

            abs_file = os.path.join(root, file)
            zipfolder.write(abs_file, rel_file)
            log("Adding", rel_file, args)


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

    # Remove all zip folders.
    for file in os.listdir():
        if file.lower().endswith(".zip"):
            os.remove(file)
            log("Removed zip folder.", file, args, process="Preprocessor")

    # Create zip folder
    folder = zipfile.ZipFile("code.zip", "w")
    log("Created zip folder.", folder.filename, args, process="Preprocessor")
    add_files_to_zip(folder, args)
    folder.close()

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
                log("Bad request. Error:", e, args, process="request")

        if response != None:
            log("HTTP Code:", str(response.status_code), args, process="Response")
        
            if response.status_code != 200:
                infos = re.findall(    
                    r'<font\b[^>]*\bcolor\s*=\s*"red"[^>]*>(.*?)</font>',
                    response.text,
                    re.IGNORECASE | re.DOTALL
                )

                error = str(infos[1])
                log("Bad response. Error:", error, args, process="Response")

            response.close()


