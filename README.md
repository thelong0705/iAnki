# iAnki
A website to help users study with flash card
https://i-anki.herokuapp.com/
### Setup on Mac Mojave
MySQL
```
brew install mysql
brew services start mysql
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
Redis
```
brew install redis
brew services start redis
```
Elasticsearch
```
brew install elasticsearch
brew services start elasticsearch
```

Mailcatcher
```
gem install mailcatcher
mailcatcher
```

Foreman
```
gem install foreman
```

Application
```
git clone https://github.com/thelong0705/iAnki
cd iAnki
echo "MYSQL_PASSWORD: 'your_mysql_pass'" >> config/local_env.yml
bundle
rails db:create
rails db:migrate
rails db:seed
foreman start -f Procfile.dev
```
If you have trouble with install mysql2 gem you can look it up here  
https://dev.to/morinoko/using-mysql-with-rails-6-and-installing-mysql-on-mac-macos-mojave-di3

