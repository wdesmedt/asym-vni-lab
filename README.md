# Asymmetric VNI Lab

This repository contains a Containerlab topology for testing and demonstrating asymmetric VNI configurations in VXLAN environments. In the current SR Linux implementation, asymmetric VNI setups are supported but only with a maximum of one VNI per remote VTEP per local network-instance. This lab illustrates how this limitation can be worked around by announcing different BGP NHs by a remote leaf (`leaf3`) that gets imported into the same network-instance `ipvrf-1` on `leaf1` and `leaf2`.

## Overview

`leaf3` has multiple VRFs configured:
- `ipvrf-3`: has RT=1:1003 and a VXLAN-interface associated with VNI=1003. This gets imported into `ipvrf-1` on `leaf1` and `leaf-2` without any explicit export policy on `leaf-3`
- `ipvrf-4` and `ipvrf-5`: have RT=1:1004 and RT=1:1005 resp. and a VXLAN-interface associated with VNI=1004, VNI=1005.. This also gets imported into `ipvrf-1` on `leaf1` and `leaf-2` but with an export policy that sets the BGP next-hop to a unique IP address associated with a loopback interface (`lo0.999`) in the default network-instance on `leaf-3`.  This _mimics_ different VTEPs from the remote leaf's perspective.

## Prerequisites

- [Containerlab](https://containerlab.dev/) installed
- Docker runtime
- Appropriate network device images

## Topology

![Network Topology](asym_vni.drawio.svg)

## Usage

Deploy the lab:
```bash
containerlab deploy -t asym-vni.clab.yml
```

Destroy the lab:
```bash
containerlab destroy -t asym-vni.clab.yml
```

## Lab Files

- `asym-vni.clab.yml` - Containerlab topology definition
- `asym_vni.drawio.svg` - Network topology asym_vni (editable with draw.io)
- `fcli.rc`: optional - source this file to use [fcli](https://github.com/srl-labs/nornir-srl) in this lab]
- `inv/*`: optional - Ansible inventory and vars
- `intent/*`: optional - Intent files for [Ansible playbook](https://github.com/srl-labs/intent-based-ansible-lab)

  
## Configuration

Refer to the individual device configurations in the lab topology file for specific VXLAN and VNI settings.

## License

This project is provided as-is for educational and testing purposes.
