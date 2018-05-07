## Endpoints contribution
- POST /contributions --> els parametres contribution:{title, url, text}
- GET /contribution/:id --> Contributions.find(params[:id])
- PUT /contributions/:id --> ContributionsController.update
- DELETE /contributions/:id --> ContributionsController.destroy

## Endpoints comments
- POST /contributions/:contributionId/comments --> CommentsController.create
- GET /contributions/:contributionId/comments/:id --> Comments.find(params[:id])
- PUT /contributions/:contributionId/comments/:id --> CommentsController.update
- DELETE /contributions/:contributionId/comments/:id --> CommentsController.destroy

## Endpoints Users
- POST /users --> UsersController.new
- GET /users/:id --> Users.find(params[:id])
- PUT /users/:id --> UsersController.update
- DELETE /users/:id --> UsersContoller.destroy


