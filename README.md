# iAnki
A website to help users study with flash card
### Setup on Mac Mojave
MySQL
```
brew install mysql
```
Yarn
```
brew install yarn
```
Node  
https://nodejs.org/en/

RUBY
```
brew install rbenv
rbenv install 2.6.3
```

Application
```
git clone https://github.com/thelong0705/iAnki
cd iAnki
echo "MYSQL_PASSWORD: 'your_mysql_pass'" >> config/local_env.yml
bundle
rails db:create
rails db:migrate
rails s
```

If you have trouble with install mysql2 gem you can look it up here  
https://dev.to/morinoko/using-mysql-with-rails-6-and-installing-mysql-on-mac-macos-mojave-di3
