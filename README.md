# Nyaaflix

Nyaaflix is a simple bash script that will scrape the website nyaa.iss.ink, fetch the magnet url of torrent for the requested show and stream it using peerflix.


## Dependencies

- `peerflix`
- `node (nodejs)`
- `curl`
- `mpv`
- `fzf`
- `bash`


## Installation

1. First install the dependencies listed above using your package manager
2. Follow the following instructions


### Root install using git (You can use this if you're not sure which install method to pick)

```bash
git clone https://github.com/zypherfunk/nyaaflix
cd nyaaflix
sudo cp nyaaflix.sh /usr/local/bin/nyaaflix
cd ..
rm -rf nyaaflix/
```


### Root install using curl

```bash
curl -L "https://raw.githubusercontent.com/zypherfunk/nyaaflix/main/nyaaflix.sh" | sudo tee /usr/local/bin/nyaaflix
sudo chmod +x /usr/local/bin/nyaaflix
```


### User install using curl

```bash
curl -L "https://raw.githubusercontent.com/zypherfunk/nyaaflix/main/nyaaflix.sh" > ~/.local/bin/nyaaflix
chmod +x ~/.local/bin/nyaaflix
```

Add ~/.local/bin to PATH if not added. Change to zshrc if your'e using that.

```bash
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
```


### Usage

`nyaaflix <Search Term>`

Eg: `nyaaflix Chainsaw man`
