get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  @errors = errors
  @form_data = session.delete(:form_data) if session[:form_data]
  p @errors
  erb :create_event
end

post '/events/create' do
  inputted_date = params[:form][:date]
  params[:form][:date] = Chronic.parse(inputted_date)
  event = Event.new(params[:form])
  if event.valid?
    event.save
    redirect "/events/#{event.id}/show"
  else
    session[:errors] = event.errors
    p params[:form]
    session[:form_data] = convert_for_session(params[:form])
    redirect '/events/new'
  end
end
