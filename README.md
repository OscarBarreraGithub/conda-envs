# Set up:
Step 1: Create the Git Repo
```
mkdir ~/conda-envs
cd ~/conda-envs
git init
touch README.md
git add README.md
git commit -m "Initial commit"
```
Connect to GitHub
Go to GitHub and create a new repo — e.g., conda-envs.
Back in your terminal:

```
git remote add origin https://github.com/YOUR_USERNAME/conda-envs.git
git branch -M main
git push -u origin main
```

Step 2: Create Your Script
export all Conda environments to .yml files.
```
nano ~/conda-envs/export_all_envs.sh
```

and paste in
```
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
```
chmod +x ~/conda-envs/export_all_envs.sh
```



Step 3: Add a Shell Alias
In your .bashrc or .zshrc:
```
alias condapush="~/conda-envs/export_all_envs.sh"
```
and reload the shell
```
source ~/.bashrc   # or ~/.zshrc
```



# Usage

Install something new:
```
conda activate my-env
conda install scikit-learn
```

Push updates to GitHub:
```
condapush
```

# Recreating Environments on a New Machine

Clone your repo:
```
git clone https://github.com/OscarBarreraGithub/conda-envs.git
cd conda-envs
```

Then recreate the environment:
```
conda env create -f my-env.yml
```

Activate it:
```
conda activate my-env
```

Done! All packages (including pip ones) are restored.

