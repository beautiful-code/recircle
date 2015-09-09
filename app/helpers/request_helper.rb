module RequestHelper
  def request_status request
    s = ['Pending','Accepted','Declined','Canceled']
    s[request.status]
  end
end
