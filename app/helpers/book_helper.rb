module BookHelper
  def format_time (time)
    time.strftime("%d/%m/%Y at %I:%M %p")
  end
end
