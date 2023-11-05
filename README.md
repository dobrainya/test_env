# The environment for test project

This project will prepare an environment with all the necessary tools and containers for running the [test project](https://github.com/dobrainya/test).

1. Install Git

```bash
sudo apt install git
```

2. Clone the environment project

```bash
git clone https://github.com/dobrainya/test_env.git
```

3. Run installation script
```bash
cd test_env
./install.sh
```
4. Reboot your system
5. Navigate to the project folder and run `docker compose` command
```bash
cd test_env
docker compose up
```
6. Open the web application by specifying the address `test.local`
