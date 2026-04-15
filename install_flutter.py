import os
import urllib.request
import zipfile
import sys

tooling_dir = r"E:\laptrinhdanentang\tooling"
mingit_url = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/MinGit-2.44.0-64-bit.zip"
flutter_url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.3-stable.zip"

os.makedirs(tooling_dir, exist_ok=True)

def download_and_extract(url, zip_path, extract_path):
    os.makedirs(extract_path, exist_ok=True)
    print(f"Downloading {url} to {zip_path}...")
    try:
        urllib.request.urlretrieve(url, zip_path)
        print("Extracting...")
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_path)
        print(f"Extracted to {extract_path}")
    except Exception as e:
        print(f"Error: {e}")
        if os.path.exists(zip_path):
            os.remove(zip_path)

mingit_zip = os.path.join(tooling_dir, "mingit.zip")
mingit_dir = os.path.join(tooling_dir, "git")
if not os.path.exists(os.path.join(mingit_dir, "cmd", "git.exe")):
    download_and_extract(mingit_url, mingit_zip, mingit_dir)

flutter_zip = os.path.join(tooling_dir, "flutter.zip")
flutter_dir = tooling_dir # flutter zip already contains "flutter" folder inside
if not os.path.exists(os.path.join(tooling_dir, "flutter", "bin", "flutter.bat")):
    download_and_extract(flutter_url, flutter_zip, flutter_dir)

print("Installation done.")
