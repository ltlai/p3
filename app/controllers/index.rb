get '/' do
  @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  @message = session[:message]
  erb :sign_in
end

post '/sessions' do
  user = User.login(params[:email], params[:password])
  if user
    session[:id] = user.id
    redirect '/'
  else
    session[:message] = "Invalid login"
    redirect '/sessions/new'
  end
end

delete '/sessions/:id' do
  session[:id] = nil
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  User.create(params[:user])
  session[:message] = "New account created"
  redirect '/sessions/new'
end
