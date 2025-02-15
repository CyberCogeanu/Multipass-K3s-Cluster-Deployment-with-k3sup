**Project Title:** Multipass K3s Cluster Deployment with k3sup

**Project Description:**

This project automates the deployment of a Kubernetes cluster on Multipass virtual machines using k3sup. It provisions 3 master nodes and 2 worker nodes, pre-configured with all necessary dependencies.

**Features:**

  * Automates Multipass VM creation.
  * Leverages k3sup for streamlined Kubernetes cluster deployment.
  * Disables Traefik to avoid conflicts.
  * Provides a simple and reproducible setup process.

**Prerequisites:**

  * **Multipass:** Install Multipass by following the instructions at [https://multipass.run/](https://www.google.com/url?sa=E&source=gmail&q=https://multipass.run/).
  * **Terraform:**  Download and install Terraform from [https://www.terraform.io/](https://www.google.com/url?sa=E&source=gmail&q=https://www.terraform.io/).
  * **k3sup:** Install k3sup using the command: `curl -sLS https://get.k3sup.dev | sh`
  * **jq:**  Install jq for JSON processing. Installation instructions vary depending on your OS.

**Setup:**

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/your-username/k3sup_multipass_terraform.git
    cd k3sup_multipass_terraform
    ```

2.  **Create Multipass VMs:**

    ```bash
    multipass launch --name k3s-master-1 --memory 2G --disk 10G --cloud-init cloud-config.yaml
    multipass launch --name k3s-master-2 --memory 2G --disk 10G --cloud-init cloud-config.yaml
    multipass launch --name k3s-master-3 --memory 2G --disk 10G --cloud-init cloud-config.yaml
    multipass launch --name k3s-slave-1 --memory 2G --disk 10G --cloud-init cloud-config.yaml
    multipass launch --name k3s-slave-2 --memory 2G --disk 10G --cloud-init cloud-config.yaml
    ```

3.  **Generate the 'hosts.json' file:**

    ```bash
    multipass list | awk 'NR>1 {print "{\"hostname\": \"" $1 "\", \"ip\": \"" $3 "\"}"}' | jq -s '.' > hosts.json
    ```

4.  **Generate the 'bootstrap.sh' script:**

    ```bash
    k3sup plan hosts.json --user ubuntu --servers 3 --server-k3s-extra-args "--disable traefik" --background > bootstrap.sh
    chmod +x bootstrap.sh
    ```

5.  **Run the 'bootstrap.sh' script:**

    ```bash
    ```

./bootstrap.sh

```

**Accessing the Cluster:**

After the script completes, you can access the cluster using the generated `kubeconfig` file.

**Troubleshooting:**

* **SSH Issues:**  Ensure that SSH keys are properly configured and that you can SSH into the VMs.
* **Network Connectivity:** Verify that the VMs can communicate with each other.
* **k3sup Errors:** Refer to the k3sup documentation for troubleshooting information.

**Project Name Evaluation:**

The current name "k3sup_multipass_terraform" is descriptive but could be improved. Here are some alternative suggestions:

* **Multipass K3s Cluster:**  Simple and clearly conveys the purpose.
* **k3sup Multipass Provisioner:** Emphasizes the automation aspect.
* **Automated K3s on Multipass:**  Highlights the key technologies and outcome.

I recommend choosing a name that is concise, easy to remember, and clearly reflects the project's goal.

**Additional Notes:**

* Consider adding a diagram illustrating the cluster architecture.
* Include a section on how to customize the deployment (e.g., changing the number of nodes, adding different configurations).
* Provide instructions on how to clean up and remove the resources created by the project.