## Setup swap space based on size and path.
## Args: -p <swap_space_path> -s <swap_size_gb> [-r]

set -e

usage() {
  echo "usage: $0 [-p <swap_space_path> [-p <string>]" 1>&2;
  exit 1;
}

remove_existing_swap_files=false

while getopts ":p:s:r" arg; do
  case $arg in
    p) swap_space_path=$OPTARG;;
    s) swap_size_gb=$OPTARG;;
    r) remove_existing_swap_files=true;;
    *) usage;;
  esac
done

if [ -z "${swap_space_path}" ] || [ -z "${swap_size_gb}" ]; then
  usage
fi

if $remove_existing_swap_files 
then
  echo "Removing existing swap files"
  swapon --show=NAME | tail -n +2 | while read -r swap_file ; do
    echo "Removing swap $swap_file"
    swapoff $swap_file
    rm $swap_file
  done
fi

echo "Allocating ${swap_size_gb}G to $swap_space_path"
fallocate -l ${swap_size_gb}G $swap_space_path
chmod 600 $swap_space_path
echo
echo "Creating swap $swap_space_path"
mkswap $swap_space_path
echo
echo "Enabling swap $swap_space_path"
swapon $swap_space_path
