
# Hacker News with Ruby on Rails

## Integrants del equip
- Alex Huang Feng
- Pau González Montiel
- Carla Varea Parra
- Sergi Ventura

## Aplicació desplegada a Heroku
[Aplicació a Heroku](https://g11d-hackernews.herokuapp.com/)

## YAML per al swagger
[Swagger](https://bitbucket.org/ahuangfeng/g11d_hackernews/src/master/public/api/api.yaml)

### Per a fer deploy a Heroku
- Si s'ha creat una nova taula a la BD : `heroku run rake db:migrate`
- Si dona un error chungo al fer el migrate a heroku:  `heroku pg:reset`, i despres fer el migrate un altre cop
- Deploy : `git push heroku master`