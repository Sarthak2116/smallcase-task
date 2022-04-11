# Smallcase Task

Run a http server inside a docker container in an EC2 server which returns a list of all EC2s running in a region in an AWS account along with their corresponding IPs and Tags when called on the `/ec2` path

## Stack Used

I have used terraform to create all the resources in AWS.

Resources created are:

- EC2

- Launch template

- ASG

- Target Group

- Entry in the ALB

- Security Group


## Application for fetching details of EC2 instances in a region

I have used FastAPI to create a simple service with `/ec2` path, which will return a JSON response with all the details of the EC2 instances in the `ap-south-1` region. I have dockerized the application and have added the dockerfile in this repo.

In the code you just need to edit the access-key and secret-key. You can also provide them as env variables while running the docker container.

```
docker build -t sc-api .
```

```
docker run -p 8000:8000 sc-api -e access_key='xxxxx' -e secret_key='xxxxxxx'
```
Below is the output screen :-

![](https://github.com/Sarthak2116/smallcase-task/blob/main/Screenshot%20from%202022-04-10%2020-29-04.png?raw=true)

## Ansible script to bootstrap the EC2 instance for installing docker to run the application container.

```
---
- hosts: all
  become: true
  vars:
    container_count: 4
    default_container_name: docker
    default_container_image: ubuntu
    default_container_command: sleep 1d

  tasks:
    - name: Install aptitude
      apt:
        name: aptitude
        state: latest
        update_cache: true

    - name: Install required system packages
      apt:
        pkg:
          - apt-transport-https
          - ca-certificates
          - curl
          - software-properties-common
          - python3-pip
          - virtualenv
          - python3-setuptools
        state: latest
        update_cache: true

    - name: Add Docker GPG apt Key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: Add Docker Repository
      apt_repository:
        repo: deb https://download.docker.com/linux/ubuntu focal stable
        state: present

    - name: Update apt and install docker-ce
      apt:
        name: docker-ce
        state: latest
        update_cache: true
```

