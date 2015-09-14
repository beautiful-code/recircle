module RequestHelper
  def request_status request
    s = ['Pending','Accepted','Declined','Canceled']
    s[request.status]
  end
  def request_type request
    s = ['Give Away ','Lend ']
    s[request.request_type]
  end
end
