This repo is a snapshot of my personal setup for working efficiently on my home machine. It includes:

- My `~/.zshrc` with handy aliases and functions
- A custom LaTeX template for cleaner Jupyter → PDF exports
- Automated Conda environment backups with full setup instructions

Feel free to explore, borrow, or adapt anything that’s useful to you!

# Conda Environment Backup

This repo automatically keeps my Conda environments backed up as `.yml` files.

A `.yml` file is a complete specification of a Conda environment, including:

- **Environment name**
- **Channels** (where packages come from)
- **Exact package versions** (Conda and pip)
- **Interpreter version** (e.g. Python 3.10)

### How it works

Whenever I install or update packages, I run a **single command** that:

1. Exports all non-base environments to YAML files
2. Commits and pushes them to this repo

This keeps everything in sync and reproducible across machines — no manual tracking needed.

## Set Up Your Own Backup:
Step 1: Create the Git Repo
```bash
mkdir ~/conda-envs
cd ~/conda-envs
git init
touch README.md
git add README.md
git commit -m "Initial commit"
```
Go to github.com and create a new repo — e.g., conda-envs. Back in your terminal, run

```bash
git remote add origin https://github.com/YOUR_USERNAME/conda-envs.git
git branch -M main
git push -u origin main
```

Step 2: Export all Conda environments to .yml files.
```bash
vim ~/conda-envs/export_all_envs.sh
```

and paste in
```bash
#!/bin/bash
cd ~/conda-envs || exit 1
mkdir -p exports

# Export each environment
for env in $(conda env list | awk '{print $1}' | grep -v "#" | grep -v "base"); do
    echo "Exporting $env..."
    conda env export -n "$env" --no-builds > "exports/$env.yml"
done

# Commit and push changes
git add exports/*.yml
git commit -m "Update Conda envs"
git push
```

Then make it executable:
```bash
chmod +x ~/conda-envs/export_all_envs.sh
```



Step 3: Add a Shell Alias
In your .bashrc or .zshrc:
```bash
alias condapush="~/conda-envs/export_all_envs.sh"
```
and reload the shell
```bash
source ~/.bashrc   # or ~/.zshrc
```



## Usage

Install something new:
```bash
conda activate my-env
conda install scikit-learn
```

Push updates to GitHub:
```bash
condapush
```

## Recreating Environments on a New Machine

Clone your repo:
```bash
git clone https://github.com/YOUR_USERNAME/conda-envs.git
cd conda-envs
```

Then recreate the environment:
```bash
conda env create -f my-env.yml
```

Activate it:
```bash
conda activate my-env
```

Done! All packages (including pip ones) are restored.



# Shell Config: ~/.zshrc

To keep my shell configuration version-controlled, I store my `~/.zshrc` in this repo and symlink it from `$HOME`. This makes it easy to use the aliases and functions I've defined across machines.

### Set it up:
```bash
cd conda-envs
```
Move real file into the repo
```bash
mv ~/.zshrc zshrc
```

Make a symlink back to $HOME
```bash
ln -s "$(pwd)/zshrc" ~/.zshrc
```
```$(pwd)``` expands to the absolute path of the repo, so the link works even if
you later cd around or reboot. Now you're ready to commit the file
```bash
git add zshrc
git commit -m "Track zshrc via symlink"
git push
```

# Jupyter PDF Export Template

This repo includes a custom LaTeX template for exporting Jupyter notebooks to clean PDFs since I didn't like the default formatting.

To use it:
1. Make sure LaTeX is installed on your machine.
2. Set up the `PDFExporter` Conda environment from the `.yml` file
3. Convert a Jupyter notebook to PDF using the `jpdf` helper function I defined in ```~/.zshrc```

```bash
   jpdf <notebook>.ipynb "Title"
```
   


