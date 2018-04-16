
# Hacker News with Ruby on Rails

## Integrants del equip
- Alex Huang Feng
- Pau González Montiel
- Carla Varea Parra
- Sara Bourjila
- Sergi Ventura

# Per a fer deploy a Heroku
- Si s'ha creat una nova taula a la BD : `heroku run rake db:migrate`
- Si dona un error chungo al fer el migrate a heroku:  `heroku pg:reset`, i despres fer el migrate un altre cop
- Deploy : `git push heroku master`