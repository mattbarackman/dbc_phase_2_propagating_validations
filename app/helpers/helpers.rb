### Place functionality that is shared between controllers or views here.

helpers do
  def errors
    session.delete(:errors) if session[:errors]
  end

  def convert_for_session(form_data)
    data = {}
    form_data.each do |key, value|
      data[key.to_sym] = value
    end
    data
  end

  def format_date(date)
    date.nil? ? nil : date.strftime("%D")
  end
  
end