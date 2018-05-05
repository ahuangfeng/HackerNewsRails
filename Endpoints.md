# Endpoints
Treure amb `rake routes`

                         Prefix Verb   URI Pattern                                                                     Controller#Action
                          users GET    /users(.:format)                                                                users#index
                                POST   /users(.:format)                                                                users#create
                       new_user GET    /users/new(.:format)                                                            users#new
                      edit_user GET    /users/:id/edit(.:format)                                                       users#edit
                           user GET    /users/:id(.:format)                                                            users#show
                                PATCH  /users/:id(.:format)                                                            users#update
                                PUT    /users/:id(.:format)                                                            users#update
                                DELETE /users/:id(.:format)                                                            users#destroy
                  contributions GET    /contributions(.:format)                                                        contributions#index
                                POST   /contributions(.:format)                                                        contributions#create
               new_contribution GET    /contributions/new(.:format)                                                    contributions#new
              edit_contribution GET    /contributions/:id/edit(.:format)                                               contributions#edit
                   contribution GET    /contributions/:id(.:format)                                                    contributions#show
                                PATCH  /contributions/:id(.:format)                                                    contributions#update
                                PUT    /contributions/:id(.:format)                                                    contributions#update
                                DELETE /contributions/:id(.:format)                                                    contributions#destroy
                        replies GET    /replies(.:format)                                                              replies#index
                                POST   /replies(.:format)                                                              replies#create
                      new_reply GET    /replies/new(.:format)                                                          replies#new
                     edit_reply GET    /replies/:id/edit(.:format)                                                     replies#edit
                          reply GET    /replies/:id(.:format)                                                          replies#show
                                PATCH  /replies/:id(.:format)                                                          replies#update
                                PUT    /replies/:id(.:format)                                                          replies#update
                                DELETE /replies/:id(.:format)                                                          replies#destroy
   contribution_comment_replies POST   /contributions/:contribution_id/comments/:comment_id/replies(.:format)          replies#create
edit_contribution_comment_reply GET    /contributions/:contribution_id/comments/:comment_id/replies/:id/edit(.:format) replies#edit
     contribution_comment_reply PATCH  /contributions/:contribution_id/comments/:comment_id/replies/:id(.:format)      replies#update
                                PUT    /contributions/:contribution_id/comments/:comment_id/replies/:id(.:format)      replies#update
                                DELETE /contributions/:contribution_id/comments/:comment_id/replies/:id(.:format)      replies#destroy
          contribution_comments POST   /contributions/:contribution_id/comments(.:format)                              comments#create
      edit_contribution_comment GET    /contributions/:contribution_id/comments/:id/edit(.:format)                     comments#edit
           contribution_comment PATCH  /contributions/:contribution_id/comments/:id(.:format)                          comments#update
                                PUT    /contributions/:contribution_id/comments/:id(.:format)                          comments#update
                                DELETE /contributions/:contribution_id/comments/:id(.:format)                          comments#destroy
            upvote_contribution POST   /contributions/:id/upvote(.:format)                                             contributions#upvote
                                POST   /contributions(.:format)                                                        contributions#create
                                GET    /contributions/new(.:format)                                                    contributions#new
                                GET    /contributions/:id/edit(.:format)                                               contributions#edit
                                GET    /contributions/:id(.:format)                                                    contributions#show
                                PATCH  /contributions/:id(.:format)                                                    contributions#update
                                PUT    /contributions/:id(.:format)                                                    contributions#update
                                DELETE /contributions/:id(.:format)                                                    contributions#destroy
                           root GET    /                                                                               contributions#index
                                GET    /auth/:provider/callback(.:format)                                              sessions#create
                         logout GET    /logout(.:format)                                                               sessions#destroy
                       comments GET    /comments(.:format)                                                             comments#index
                                GET    /comments/:id(.:format)                                                         comments#show
                                POST   /comments/:id(.:format)                                                         replies#create