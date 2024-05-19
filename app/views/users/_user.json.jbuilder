json.extract! user, :id, :auth_token, :email, :first_name, :last_name, :password_diggest, :user_name, :created_at, :updated_at
json.url user_url(user, format: :json)
