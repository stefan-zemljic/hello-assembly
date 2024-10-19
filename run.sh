# Check if we are in a windows git bash
if [ "$(uname -o)" == "Msys" ]; then
    # Check if we are in a 64-bit windows git bash
    if [ "$(uname -m)" != "x86_64" ]; then
        echo "This script must be run in a 64-bit Windows Git Bash"
        exit 1
    fi
else
    echo "This script must be run in a Windows Git Bash"
    exit 1
fi

# Check if the image already exists
if (docker image inspect hello-assembly-builder &> /dev/null); then
    built="y"
fi

# Check if --norebuild is not passed as argument (but only if the image already exists) (the first if condition must contain two conditions)
if [ "$built" == "y" ] && [ "$1" != "--norebuild" ]; then
  # Check if --rebuild is passed as argument
  if [ "$1" == "--rebuild" ]; then
    rebuild="y"
  fi

  # Ask the user if he wants to rebuild the image
  if [ "$rebuild" != "y" ]; then
    read -r -p "Do you want to rebuild the image? [y/N] " rebuild
  fi
fi

if [ "$built" != "y" ] || [ "$rebuild" == "y" ]; then
    if ! (docker build -t hello-assembly-builder .) then
        echo "Error building the image"
        exit 1
    fi
fi

# Run the container, executing the script assemble.sh inside the docker container
echo
docker run --rm -v "$(pwd -W):/workspace" hello-assembly-builder bash -c "bash assemble.sh"

# Run hello_win.exe
echo
echo
echo "running windows"
./hello_win.exe

# Ask the user if he wants to delete the image
echo
echo
read -r -p "Do you want to delete the image? [y/N] " delete
if [ "$delete" == "y" ]; then
    docker image rm hello-assembly-builder
fi
