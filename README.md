
# Hacker News with Ruby on Rails

## Autors del projecte
- [Alex Huang Feng](https://github.com/ahuangfeng)
- [Pau González Montiel](https://github.com/pgonzalez96)
- [Carla Varea Parra](https://github.com/carlavarea)

## Aplicació desplegada a Heroku
[Aplicació a Heroku](https://g11d-hackernews.herokuapp.com/)

## YAML per al swagger
[Swagger](https://g11d-hackernews.herokuapp.com/api/api.yaml)

## Segona versió Fron-End fet amb Angular
[Repo Github](https://github.com/ahuangfeng/HackerNewsAngular)

## Per a fer deploy a Heroku
- Si s'ha creat una nova taula a la BD : `heroku run rake db:migrate`
- Si dona un error chungo al fer el migrate a heroku:  `heroku pg:reset`, i despres fer el migrate un altre cop
- Deploy : `git push heroku master`