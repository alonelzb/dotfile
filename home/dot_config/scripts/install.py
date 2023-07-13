from locale import bindtextdomain
from tqdm import tqdm
import sh
from time import sleep
from pathlib import Path
import requests
import re
import shutil


lsd = "https://api.github.com/repos/lsd-rs/lsd/releases/latest"
fd = "https://api.github.com/repos/sharkdp/fd/releases/latest"
bat = "https://api.github.com/repos/sharkdp/bat/releases/latest"
atuin = "https://api.github.com/repos/ellie/atuin/releases/latest"
zoxide = "https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest"
xh = "https://api.github.com/repos/ducaale/xh/releases/latest"

rg = "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"


headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36",
    "Cookie": "_octo=GH1.1.663094429.1684229151; preferred_color_mode=light; tz=Asia%2FShanghai; color_mode=%7B%22color_mode%22%3A%22light%22%2C%22light_theme%22%3A%7B%22name%22%3A%22light_tritanopia%22%2C%22color_mode%22%3A%22light%22%7D%2C%22dark_theme%22%3A%7B%22name%22%3A%22dark_tritanopia%22%2C%22color_mode%22%3A%22dark%22%7D%7D; logged_in=yes; dotcom_user=alonelzb",
    # "Authorization": "Token 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",
}


def download(url):
    tar_name = url.split("/")[-1]
    res = requests.get(url, headers=headers, stream=True)
    size = int(res.headers["Content-Length"])
    with tqdm(
        unit="B",
        unit_scale=True,
        unit_divisor=1024,
        miniters=1,
        desc=f"Downloading {tar_name}",
        total=size,
    ) as pbar:
        with open(f"/tmp/{tar_name}", "wb") as fb:
            for chunk in res.iter_content(chunk_size=8192):
                fb.write(chunk)
                pbar.update(len(chunk))

    return tar_name


def get_download_url(url):
    res = requests.get(url, headers=headers)

    if res.status_code == 200:
        result = re.findall(
            '"browser_download_url": "(.*?x86_64-unknown-linux-musl.tar.gz)"', res.text
        )
        if result:
            download_url = result[0]
            return download_url

    print(res.status_code, "response none")
    exit()


def set_nvim():
    neovim_url = (
        "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
    )
    if Path("/usr/local/nvim-linux64").exists():
        print("neovim is existed in /usr/local/")
    else:
        download(neovim_url)
        sh.contrib.sudo("tar", "-xzf", "nvim-linux64.tar.gz", "-C", "/usr/local/")
        print("neovim install /usr/local/")


def unpack_and_move(tar_name, target=""):
    dirname = tar_name.rstrip(".tar.gz")
    bin_name = tar_name.split("-")[0]
    #
    shutil.unpack_archive(f"/tmp/{tar_name}", f"/tmp/{dirname}")

    if Path(f"/tmp/{dirname}/{dirname}/").exists():
        if bin_name == "ripgrep":
            bin_name = "rg"
        shutil.copy2(
            f"/tmp/{dirname}/{dirname}/{bin_name}", Path.home() / ".local/bin/"
        )
    else:
        shutil.copy2(f"/tmp/{dirname}/{bin_name}", Path.home() / ".local/bin/")
    print(f"move {bin_name} --> ~/.local/bin")

    shutil.rmtree(f"/tmp/{dirname}")


def remove():
    file = "lsd-0.23.1-x86_64-unknown-linux-musl.tar.gz"
    dirname = file.strip(".tar.gz")
    print(f"deleted: {dirname}")


# set_nvim()
# unpack_and_move()
if __name__ == "__main__":
    set_nvim()

    # exit()
    targets = [zoxide, atuin, lsd, fd, bat, xh, rg]
    for target in targets:
        bin_name = target.split("/")[-3]
        if (Path.home() / ".local/bin/" / bin_name).exists():
            print(f"{bin_name} is in ~/.local/bin")
        else:
            print(f"{bin_name} not found, download...")
            download_url = get_download_url(target)
            print(download_url)

            tar_name = download(download_url)
            print(f"{tar_name} downloaded in /tmp")

            unpack_and_move(tar_name)
            # break
