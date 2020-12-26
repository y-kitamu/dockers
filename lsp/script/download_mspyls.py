import os
import urllib.request
import xml.etree.ElementTree as ET
from datetime import datetime as dt
import zipfile

TEMPLATE = "/python-language-server-{}?restype=container&comp=list&prefix=Python-Language-Server-{}-x64"


def download_xml_and_get_latest_url(
        base_url="https://pvsc.blob.core.windows.net", channel="stable", os_type="linux"):
    url = base_url + TEMPLATE.format(channel, os_type)
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req) as res:
        body = res.read().decode()
    root = ET.fromstring(body)
    latest_date = None
    latest_ver = None
    for blob in root.iter('Blob'):
        date_str = blob.find('Properties').find('Last-Modified').text
        date = dt.strptime(date_str, "%a, %d %b %Y %H:%M:%S %Z")
        if latest_date is None or date > latest_date:
            latest_date = date
            latest_ver = blob.find('Url').text
    return latest_ver


def install_mspyls(url, dst_dir="./mspyls", force_overwrite=True):
    print("Download from {}".format(url))
    req = urllib.request.Request(url)
    basename = os.path.basename(url)
    zipfname = os.path.join("./", basename + ".zip")
    if not os.path.exists(zipfname) or force_overwrite:
        with urllib.request.urlopen(req) as res, open(zipfname, 'wb') as f:
            f.write(res.read())
    zfile = zipfile.ZipFile(zipfname)
    zfile.extractall(os.path.join(dst_dir))

    
if __name__ == "__main__":
    url = download_xml_and_get_latest_url()
    install_mspyls(url, force_overwrite=True)
