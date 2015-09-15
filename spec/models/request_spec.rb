require 'rails_helper'

describe 'Request' , type: :model do
  before do
    @pending_request = Request.new(user_id:1,book_id:1,owner_id:2,status:Request::PENDING_CODE,request_type:Request::GIVE_AWAY)
  end
  it "should not have same owner and requester" do
    @pending_request.owner== @pending_request.requester
  end
end
