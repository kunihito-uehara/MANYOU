#task h1

| column  | type   |
| ------- | ------ |
| title   | string |
| content | string |

## Heroku へのデプロイ手順

1. Heroku CLI のインストール

```
brew tap heroku/brew && brew install heroku
```

2. Heroku にログイン

```
heroku login
```

3. ~/workspace/○○_app に位置していることを確認

4. Heroku に新しいアプリケーションを作成
   (heroku-20 では、Ruby2.6.5 がサポートの対象外なので heroku-18 で)

```
$ heroku create --remote heroku-18 --stack heroku-18
```

5. アセットプリコンパイル

```
$ rails assets:precompile RAILS_ENV=production
```

6. コミット

```
$ git add -A
$ git commit -m "＊＊＊"
```

7. Heroku buildpack を追加

```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

8. Heroku にデプロイ

```
$ git push heroku-18 master
```

9. データベースの移行

```
$ heroku run rails db:migrate
```
