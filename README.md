# TODO

## blockers

* weave doesn't work at present

## changes

* removed DO; ufw has a lot of hacks for SCW now
* we're now running on C2S, not VC2S so we can feed extra volumes to gluster in the future
* default cluster is brought up with 50G root volume and 50G gluster volume. This comes out to about EUR 30,- a month, not 10!

# Kubernetes cluster setup automation

> This is part of the Hobby Kube project. Functionality of the modules is described in the [guide](https://github.com/hobby-kube/guide).

Deploy a secure Kubernetes cluster on [Scaleway](https://www.scaleway.com/) or [DigitalOcean](https://www.digitalocean.com/) using [Terraform](https://www.terraform.io/).

## Setup

### Requirements

The following packages are required to be installed locally:

```sh
brew install terraform kubectl jq wireguard-tools
```

Modules are using ssh-agent for remote operations. Add your SSH key with `ssh-add -K` if Terraform repeatedly fails to connect to remote hosts.

### Configuration

Export the following environment variables depending on the modules you're using.

#### Using Scaleway as provider

```sh
export TF_VAR_scaleway_organization=<ACCESS_KEY>
export TF_VAR_scaleway_token=<TOKEN>
```

#### Using Cloudflare for DNS entries

```sh
export TF_VAR_domain=<domain> # e.g. example.org
export TF_VAR_cloudflare_email=<email>
export TF_VAR_cloudflare_token=<token>
```

### Usage

```sh
# fetch the required modules
$ terraform get

# see what `terraform apply` will do
$ terraform plan

# execute it
$ terraform apply
```

## Using modules independently

Modules in this repository can be used independently:

```
module "kubernetes" {
  source  = "github.com/hobby-kube/provisioning/service/kubernetes"
}
```

After adding this to your plan, run `terraform get` to fetch the module.
