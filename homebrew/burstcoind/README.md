# Hombrew - burstcoind (burstcoin dameon)
Formula for installing the BRS (Burst Refrence Software) wallet on macOS.

---

### What is Homebrew?
Homebrew is a package manager for macOS similar to apt-get on Linux. It is useful for installing an ever widening array of software very quickly and simply. You can read more about Homebrew on their website, [brew.sh](https://brew.sh).

### Usage
Once you have successfully installed this formula, starting the wallet is as simple as opening a Terminal window and typing `burstcoind`. The wallet will start and the chain will synchronize.

You can access the wallet UI in any web browser by navigating to `http://localhost:8125`.

### Requirements
* Java 8
* Hombrew
* MariaDB (optional - default is H2)

### How to update
If you have already used burstcoind to install the Burst wallet, you can update to any new wallet version by using the command

```
brew upgrade burstcoind
```

### How to install
Simply copy and paste the follwoing commands into a Terminal window and press enter to run.

1. Install Homebrew, skip if you already have Homebrew installed on your machine.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

2. Install Java 8, skip if you already have Java 8 installed on your machine.

```
brew cask install homebrew/cask-versions/java8
```

3. Tap the formula.

```
brew tap burst-apps-team/homebrew-burstcoind
```

4. Install the burstcoin dameon.

```
brew install burstcoind
```

5. Start the wallet.

```
burstcoind
```

---

### Changing databases from H2 to MariaDB

1. Install MariaDB.

```
brew install mariadb
```

2. Start the MariaDB server.

```
brew services start mariadb
```

3. Open the MariaDB session.

```
mysql -uroot
```

4. Run the following commands one after the other...

```
CREATE DATABASE brs;

CREATE USER ‘admin’@‘localhost’ IDENTIFIED BY ‘password’;

GRANT ALL PRIVILEGES ON brs.* TO ‘admin’@‘localhost’ IDENTIFIED BY ‘password’;

ALTER DATABASE brs CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

EXIT
```
*GitHub may change the type of single quotes, to fix this, after pasting into terminal, delete and manually reenter the single quotes.*

5. Open the `brs.properties` file.

```
sudo nano /usr/local/Cellar/burstcoind/2.2.7/bin/conf/brs.properties
```

6. Update the database configuration.

replace...
>DB.Url=jdbc:h2:./burst_db/burst;DB_CLOSE_ON_EXIT=False     
>DB.Username=sa     
>DB.Password=sa     

with...
>DB.Url=jdbc:mariadb://localhost:3306/brs     
>DB.Username=admin     
>DB.Password=password     

7. Save and confirm the edited file.

`CTRL + X` --> `y` --> `ENTER`

8. Start the wallet.

```
burstcoind
```

---

### Uninstall
If for some reason you would ever like to uninstall the BRS wallet (the wallet **must** have been installed using this formula for these instructions to work), you can do the following...

1. Untap the formula.

```
brew untap burst-apps-team/homebrew-burstcoind
```

2. Uninstall the burstcoin dameon.

```
brew uninstall --force burstcoind
```

### Deleting MariaDB database
If you switched the database from H2 to MariaDB, it is necessary to manually delete the database and user. This is not required, but if the database and user are no longer in use, **and you do not plan to use them in the future**, it is recommended.

If you plan to reinstall the wallet at a later date, you can leave these intact. When the wallet is reinstalled, the configuration can be configured to use the existing database and user, allowing you to resume syncing from the last block in the database, rather than from genesis (to do this - start at **step 5** of **Changing databases from H2 to MariaDB**).

1. Open the MariaDB session.

```
mysql -uroot
```

2. Run the following commands one after the other...

```
DROP DATABASE brs;

DROP USER 'admin'@'localhost;

EXIT
```

---

### Issues

If you have any issues, please open an issue **within THIS repository**.

In the issue, please include the following:
* Homebrew version `brew -v`
* Java Version `java --version`
* MacOS Version (Apple at top left --> About this Mac. The specific version is needed [eg. 10.13.6]).
