
apt-get update && apt-get upgrade -y
apt-get install curl -y

# Specify the file path to wait for
FILE_PATH="/shared_folder/node-token"

# Loop until the file exists
while [ ! -f "$FILE_PATH" ]; do
    echo "Waiting for file $FILE_PATH to exist..."
    sleep 3  # Wait for 1 second before checking again
done

echo "File [ $FILE_PATH ] found!"



# install k3s
echo "Installing k3s . . ."

export INSTALL_K3S_EXEC="--flannel-iface=eth1"
export K3S_URL="https://192.168.56.110:6443"
export K3S_TOKEN=$(cat "$FILE_PATH")



curl -sfL https://get.k3s.io | sh -
# Check if the worker node joined successfully
if [ $? -eq 0 ]; then
  echo "Worker node successfully joined the K3s cluster."
else
  echo "Failed to join the K3s cluster."
fi