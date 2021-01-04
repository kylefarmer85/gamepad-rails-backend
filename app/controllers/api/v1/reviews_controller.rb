class Api::V1::ReviewsController < ApplicationController
  

  def infinite_scroll
    #if user is not logged in or selects all reviews
    if !params[:user_id] 

      #sorts reviews by newest or oldest
      params[:sort_by_newest] ?

      reviews = Review.order("created_at DESC").page(params[:page_counter]).per(8)
      :
      reviews = Review.order("created_at ASC").page(params[:page_counter]).per(8)

      render json: reviews
    end  

    #if user is logged in and selects followed user's reviews
    if params[:user_id]
     
      def get_followings_reviews
        user = User.find(params[:user_id])
        reviews = []
        user.followings.each {|follower| reviews << follower.reviews}
        return reviews.flatten
      end

      followings_reviews = get_followings_reviews
      
      #sorts reviews by newest or oldest
      params[:sort_by_newest] ?

      #paginate_array allows Kaminari to work on regular arrays
      paginated_array = Kaminari.paginate_array(followings_reviews).page(params[:page_counter]).per(8).reverse
      :
      paginated_array = Kaminari.paginate_array(followings_reviews).page(params[:page_counter]).per(8)

      render json: paginated_array.to_json(:include=>:comments)  
    end  
  end


  def show
    review = Review.find(params[:id])
    render json: review
  end


  def game_reviews
    game_api_id = params[:game_api_id]
    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)

    #this will send [] to FE if game isn't already in database or is but has no reviews
    if found_game && found_game.reviews.length > 0 
      render json: found_game.reviews
    else 
      render json: []
    end
  end


  def create
    user_id = params[:user_id]
    username = params[:username]
    user_pic = params[:user_pic]
    content = params[:content]
    rating = params[:rating]
    game_name = params[:game_name]
    game_api_id = params[:game_api_id]
    game_image = params[:game_image]

    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)
   
    #if game already in db create a review with it's game id
    if found_game 
      review = Review.create(user_id: user_id, game_id: found_game.id, game_name: game_name, content: content, rating: rating, username: username, user_pic: user_pic, game_api_id: game_api_id)   

      render json: {id: review.id, user_id: review.user_id, game_id: review.game_id, game_name: review.game_name, content: review.content, rating: review.rating, username: review.username, user_pic: review.user_pic, game_api_id: review.game_api_id, comments: review.comments}

    #else create a new game in db, and then use the new game id for the new review  
    else 
      new_game = Game.create(name: game_name, image: game_image, game_api_id: game_api_id)    

      review = Review.create(user_id: user_id, game_id: new_game.id, game_name: game_name, content: content, rating: rating, username: username, user_pic: user_pic, game_api_id: game_api_id)

      render json: {id: review.id, user_id: review.user_id, game_id: review.game_id, game_name: review.game_name, content: review.content, rating: review.rating, username: review.username, user_pic: review.user_pic, game_api_id: review.game_api_id, comments: review.comments}
    end
  end


  def destroy
    review = Review.find(params[:id])
    review.destroy

    render json: review
  end

end
