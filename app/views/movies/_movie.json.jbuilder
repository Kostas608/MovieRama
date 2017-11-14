json.extract! movie, :id, :Title, :Description, :Username, :Publication_date, :Number_of_likes, :Number_of_hates, :created_at, :updated_at
json.url movie_url(movie, format: :json)
