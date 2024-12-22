FROM ubuntu:22.04
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
# Set root password for SSH access (change 'your_password' to your desired password)
RUN echo 'root:root' | chpasswd
RUN useradd -m ansible -s /bin/bash -G sudo,adm
RUN useradd -m hazem -s /bin/bash -G sudo,adm
RUN echo 'ansible:ansible' | chpasswd
RUN echo 'hazem:hazem' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p /home/ansible/.ssh
RUN mkdir -p /home/hazem/.ssh

RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBblE3IMy/vu3w69zA4hNQstFgM7g7ANOiRde2RysVKWv7Tkiqh1eupbpgGwiaU0n6+whFmtSpEQaHODcRsD7f8sYiLjzf3CvYBjdQDKDSTqYo6W804EK297tGjbuUhGXyCs2xPbzkpIU7eihVsPTSQv8VWLjq+rsV4+DmWqQ2k255u50Or+hrvQ451xmrKu5Z0luCQA4e+ToTBCSf1hJHkjgmbU7rmfXE+r980QhdN8Tsp9+iO4LTq4gHmTI6MqeZn3OwuG0stw1P3f7r2WQBsjVFvbHD2sCUr6/b2YKYWrnMIV1G3JkybPd9jjGTeodwK6xUey0Rcx+Qx2j5TolLLx03JHe9XDWZIw6LJuZFMB9HHFAkSQeJH8HgjnWwcNrKs7eoYckv1Yna9RMVAjbNzc9LYsW3srEi7E1zesTrCOWJNQAcU7XhV+eNuaMD3mLPMXQV6C/dQVJTz7TRliN444cd/FzycBK9efDyYQR/r301VdMSrZe9LV6vqGqjxJ8= hazem@hazem-VirtualBox' >> /home/ansible/.ssh/authorized_keys

RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBblE3IMy/vu3w69zA4hNQstFgM7g7ANOiRde2RysVKWv7Tkiqh1eupbpgGwiaU0n6+whFmtSpEQaHODcRsD7f8sYiLjzf3CvYBjdQDKDSTqYo6W804EK297tGjbuUhGXyCs2xPbzkpIU7eihVsPTSQv8VWLjq+rsV4+DmWqQ2k255u50Or+hrvQ451xmrKu5Z0luCQA4e+ToTBCSf1hJHkjgmbU7rmfXE+r980QhdN8Tsp9+iO4LTq4gHmTI6MqeZn3OwuG0stw1P3f7r2WQBsjVFvbHD2sCUr6/b2YKYWrnMIV1G3JkybPd9jjGTeodwK6xUey0Rcx+Qx2j5TolLLx03JHe9XDWZIw6LJuZFMB9HHFAkSQeJH8HgjnWwcNrKs7eoYckv1Yna9RMVAjbNzc9LYsW3srEi7E1zesTrCOWJNQAcU7XhV+eNuaMD3mLPMXQV6C/dQVJTz7TRliN444cd/FzycBK9efDyYQR/r301VdMSrZe9LV6vqGqjxJ8= hazem@hazem-VirtualBox' >> /home/hazem/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
