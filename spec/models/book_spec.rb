require 'rails_helper'

describe 'Book' , :type => :model do

  let(:book) { Book.create(name:'test') }

  before do
    @pending_request = book.requests.create(:status => Request::PENDING_CODE, user_id:1)
    @accepted_request = book.requests.create(:status => Request::ACCEPTED_CODE, user_id:1)
    @declined_request = book.requests.create(:status => Request::DECLINED_CODE, user_id:1)
    @other_request = Request.create(:status => Request::PENDING_CODE, user_id:1, book_id:243534)
  end

  subject { book }

  it "should always have a name" do
    book.update_attributes(name:nil)

    expect(book.errors).to include(:name)
  end

  [:owner, :borrower, :name, :requests, :unanswered_requests, :closed_requests, :lock?].each do |msg|
    it "should respond_to #{msg}" do
      expect(book).to respond_to(msg)
    end
  end

  describe "unanswered_requests" do
    it "should return all the requests for the book which are pending" do
      expect(book.unanswered_requests).to include(@pending_request)
    end

    it "should not return requests for the book which are not pending" do
      expect(book.unanswered_requests).not_to include(@accepted_request)
    end

    it "should not return requests to other books" do
      expect(book.unanswered_requests).not_to include(@other_request)
    end
  end

  describe "closed_requests" do
    it "should return all the request which are either accepted or declined" do
      expect(book.closed_requests).to include(@accepted_request)
      expect(book.closed_requests).to include(@declined_request)
    end

    it "should not return requests which are pending" do
      expect(book.closed_requests).not_to include(@pending_request)
    end

    it "should not return requests to other books" do
      expect(book.closed_requests).not_to include(@other_request)
    end
  end

  describe "lock?" do
    it "should return true if locked" do
      book.update_attributes(state:'locked')

      expect(book.lock?).to be_truthy
    end

    it "should return false if not locked" do
      book.update_attributes(state:'unlocked')

      expect(book.lock?).to be_falsey
    end
  end
end
