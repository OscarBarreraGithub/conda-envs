
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Ensure Conda’s env/bin comes before the system for gem/ruby
export PATH="$CONDA_PREFIX/bin:$PATH"

# Function to export all conda environments to github repository
alias condapush="~/conda-envs/export_all_envs.sh"






#Github Pages

webpush() {
  # 1) format everything
  npx prettier --write . || return

  # 2) stage & commit
  git add . && git commit -m "$*" || return

  # 3) pull (will fail if there’s a conflict)
  git pull || { echo "✋ git pull failed—resolve conflicts and try again."; return; }

  # 4) push
  git push
}

# Start local Jekyll server and display access URL

alias webtest='ip=$(ipconfig getifaddr en0); echo "Access your site at: http://$ip:4000"; bundle exec jekyll serve --host 0.0.0.0 --port 4000'





# function to convert Jupyter notebooks to PDF
# Usage: jpdf <notebook.ipynb> "<title>""
# If <title> is provided, it will be used as the document title.
# If <title> is not provided, the document title will suppressed.
jpdf() {                                     # use “pdf …” on the CLI
  local nbfile="$1"                         # first arg: notebook
  local title="${2:-}"                      # second arg (may be empty)

  source /opt/miniconda3/etc/profile.d/conda.sh
  conda activate PDFExporter

  if [[ -n "$title" ]]; then                # title supplied → use it
    jupyter nbconvert "$nbfile" \
      --to pdf \
      --template-file ~/conda-envs/jupyterPDFtemplate.tplx \
      --LatexPreprocessor.title "$title"
  else                                      # no title → suppress one
    jupyter nbconvert "$nbfile" \
      --to pdf \
      --template-file ~/conda-envs/jupyterPDFtemplate.tplx \
      --LatexPreprocessor.title ""
  fi
}



eval "$(rbenv init -)"
eval "$(rbenv init -)"
