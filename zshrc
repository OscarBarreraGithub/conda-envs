
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

# Function to export all conda environments to github repository
alias condapush="~/conda-envs/export_all_envs.sh"

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



