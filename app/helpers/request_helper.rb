module RequestHelper
  def request_status request
    s = ['Pending','Accepted','Declined','Canceled']
    s[request.status]
  end
  def time_format time
    return "#{time.day}-#{time.month}-#{time.year}"
  end
end
