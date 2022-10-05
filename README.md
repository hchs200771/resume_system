# README

### Version

- ruby: `2.7.0`
- rails: `7.0.4`
### 專案啟動

```bash
$ bundle install
$ rake db:migrate
$ rake db:seed
```
### 測試指令

`GET /api/v1/resumes/search?work_exprience=5&same_company=true` 測試

```bash
bundle exec rspec
```

### Use Case 1
![](https://i.imgur.com/vjZIF2h.png)
