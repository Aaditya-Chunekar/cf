# cf

A simple CLI that get any user's codeforces rating and recommends questions.
Built this for learning shell and packaging.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/Aaditya-Chunekar/cf/main/install.sh | bash
```

## Usage
Use after restarting your shell. No more than 10000 handles is accepted.
1. To get a tabular output of multiple users' stats
```bash
cf <username1> <username2> <username3> 
```
2. To get recommended problems for a single user
```bash
cf -r <username>
```
or
```bash
cf --recommend <username>
```

