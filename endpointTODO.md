## Endpoints contribution
- POST /contributions --> els parametres contribution:{title, url, text}
- GET /contribution/:id --> Contributions.find(params[:id])
- PUT /contributions/:id --> ContributionsController.update
- DELETE /contributions/:id --> ContributionsController.destroy

## Endpoints comments
- POST /contributions/:contributionId/comments --> CommentsController.create
- 
