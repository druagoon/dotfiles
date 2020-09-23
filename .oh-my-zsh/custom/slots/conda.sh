CONDA_ENV=$HOME/.conda/envs
CONDA_MACOS=$HOME/.conda/envs/macOS

function setconda() {
	if [ -d "$CONDA_ENV/$1" ]; then
		export PATH=$CONDA_ENV/$1/bin:$PATH
	fi
}
setconda macOS
